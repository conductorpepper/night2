{
  flake,
  pkgs,
  ...
}:
let
  inherit (flake) inputs;
in
{
  home.sessionVariables = {
    # wayland
    NIXOS_OZONE_WL = "1";
    MOZ_ENABLE_WAYLAND = "1";
  };

  programs.obs-studio = {
    enable = true;
    plugins = with pkgs.obs-studio-plugins; [
      wlrobs
      obs-pipewire-audio-capture
      obs-vkcapture
    ];
  };

  home.packages =
    let
      system = pkgs.stdenv.hostPlatform.system;
    in
    with pkgs;
    [
      # audio
      easyeffects

      # browser
      wike
      kiwix
      inputs.zen-browser.packages.${system}.default

      # wine
      wineWowPackages.waylandFull

      # files
      ranger
      unzip
      veracrypt
      deja-dup

      # image
      krita
      curtail
      tuxpaint
      aseprite
      glaxnimate
      gimp3-with-plugins
      kdePackages.kolourpaint

      # writing
      libreoffice-qt
      obsidian
      logseq
      zathura
      hunspell
      hunspellDicts.en_US
      pdftk
      kdePackages.kcharselect

      # mail
      thunderbird

      # pass
      keepassxc

      # video
      vlc
      mpv
      kdePackages.kdenlive
      yt-dlp

      # learning
      anki-bin

      # reading
      kdePackages.okular

      # computer
      btop
      kdePackages.ksystemlog
      kdePackages.filelight

      # meetings
      zoom-us

      # printers & scanners
      kdePackages.skanlite
      kdePackages.skanpage

      # math
      kdePackages.kcalc

      # desktop things
      app2unit
      trash-cli
    ];

  home.shellAliases = {
    # "xdg-open" = "app2unit-open";
  };

  # because i'm using zen imperatively, i just jerry rig this up
  home.file.".mozilla/native-messaging-hosts/org.kde.plasma.browser_integration.json".source =
    "${pkgs.kdePackages.plasma-browser-integration}/lib/mozilla/native-messaging-hosts/org.kde.plasma.browser_integration.json";
}
