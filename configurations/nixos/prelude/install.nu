def check-connection [] {
  let state = nmcli g status | detect columns | get STATE | first
  let connected = $state == "connected"
  if not $connected {
    gum log --level "error" "Internet connection needed!" 
    exit
  }
}

def prompt-intro [] {
  gum confirm "This flake should be configured to fit your machine.
  Otherwise, there will be unexpected consequences (i.e., disk formatting, identity, this install script, etc.).
  Proceed anyway?"
}

def prompt-hostname [] {
  let WEATHERSTATION = "weatherstation"
  let POSTSHELTER = "postshelter"
  let KEEPER = "keeper"
  gum choose --header "Select host:" $WEATHERSTATION $POSTSHELTER $KEEPER
}

def prompt-password [] {
  gum input --header "Enter password:" --password | save -f /tmp/secret.key
}

def clone-flake [] {
  if not ("night2/" | path exists) {
    gum spin --title "Cloning flake..." -- git clone "https://github.com/conductorpepper/night2/"
    sudo mv night2/ /mnt/etc/
  }
}

def prompt-irreverisble-install [hostname: string] {
  gum confirm $"This flake will now be installed for ($hostname).
  As part of this process, the disk will be overwritten and may not be proper for your machine.
  Proceed?"
}

def prompt-irreversible-install-again [] {
  gum confirm $"Final confirmation: are you sure?"
}

def commit-irreversible-install [hostname: string] {
  gum log "Formatting disk..."
  sudo nix run github:nix-community/disko -- --mode disko --flake $"/mnt/etc/night2/#($hostname)"
  gum log "Installing..."
  sudo nixos-install --flake $"/mnt/etc/night2/#($hostname)"
}

def prompt-finish [] {
  gum confirm $"This flake is now installed. Reboot?"
  print "Rebooting..."
  systemctl reboot
}

def main [] {
  gum log "~ night2 install ~"
  check-connection
  prompt-intro
  let hostname = prompt-hostname
  prompt-password
  clone-flake
  prompt-irreverisble-install $hostname
  prompt-irreversible-install-again
  commit-irreversible-install $hostname
  prompt-finish
}

