{
  config,
  pkgs,
  lib,
  ...
}: {
  programs.git = {
    enable = true;
    userEmail = "100497642+conductorpepper@users.noreply.github.com";
    userName = "conductorpepper";
  };

  programs.gh = {
    enable = true;
    gitCredentialHelper.enable = true;
  };

  programs.zsh.enable = true;
  programs.zsh.enableCompletion = true;
  programs.zsh.autosuggestion.enable = true;
  programs.zsh.initExtra = ''
    # Starship
    eval "$(starship init zsh)"
  '';

  programs.nushell = {
    enable = true;
    configFile.text = ''
      let carapace_completer = {|spans|
        carapace $spans.0 nushell ...$spans | from json
      }

      # sync with home.sessionPath for some reason
      $env.PATH = ($env.PATH |
        split row (char esep) |
        append "/home/jan/.local/bin"
      )

      $env.config.show_banner = false

      mkdir ($nu.data-dir | path join "vendor/autoload")
      starship init nu | save -f ($nu.data-dir | path join "vendor/autoload/starship.nu")
    '';
  };

  programs.starship.enable = true;
  programs.starship.enableBashIntegration = true;
  programs.starship.enableZshIntegration = true;
  programs.starship.enableNushellIntegration = true;

  programs.carapace = {
    enable = true;
    enableNushellIntegration = true;
  };

  home.shell = {
    enableBashIntegration = true;
    enableZshIntegration = true;
    enableNushellIntegration = true;
  };

  programs.ghostty = {
    enable = true;
  };

  programs.helix.enable = true;

  # apparently gio priortizes "xdg_terminal_exec" first,
  # so to set it, we do this
  home.file.".local/bin/xdg-terminal-exec" = {
    executable = true;
    text = ''
      #!${lib.getExe config.programs.nushell.package}

      def main [...args: string] {
        ${lib.getExe config.programs.ghostty.package} -e ...$args
      }
    '';

    # text = ''
    #   #!${lib.getExe config.programs.zsh.package}
    #   ${lib.getExe config.programs.ghostty.package} -e "$@"
    # '';
  };

  home.sessionVariables = {
    EDITOR = "hx";
  };

  home.sessionPath = [
    "$HOME/.local/bin"
  ];

  home.packages = with pkgs; [
    # audio
    bespokesynth
    tenacity

    # game
    trenchbroom
    godot_4

    # modeling
    blender
    blockbench

    # editors
    jetbrains.idea-community-bin
    vscodium
    zed-editor

    # blender hangs on intel integrated graphics
    # so this is a workaround
    # https://askubuntu.com/questions/1477715/blender-hangs-using-intel-integrated-graphics
    (writeShellScriptBin "blender-igp" ''
      echo 10000 | sudo tee /sys/class/drm/card1/engine/rcs0/preempt_timeout_ms
      INTEL_DEBUG=reemit blender
    '')
  ];
}
