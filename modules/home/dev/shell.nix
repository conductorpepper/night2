{
  flake,
  lib,
  config,
  ...
}:
{
  programs.bash.enable = true;
  programs.bash.enableCompletion = true;

  programs.zsh.enable = true;
  programs.zsh.enableCompletion = true;
  programs.zsh.autosuggestion.enable = true;
  programs.zsh.initContent = ''
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
        append "/home/${flake.config.me.username}/.local/bin"
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
    settings = {
      command = lib.getExe config.programs.nushell.package;
    };
  };

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
  };

  home.sessionPath = [
    "$HOME/.local/bin"
  ];
}
