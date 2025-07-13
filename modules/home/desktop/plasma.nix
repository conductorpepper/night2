{
  flake,
  lib,
  config,
  passthru,
  ...
}:
{
  imports = [
    flake.inputs.plasma-manager.homeManagerModules.plasma-manager
  ];

  programs.plasma.enable = true;
  programs.plasma.workspace.colorScheme = "BreezeDark";
  programs.plasma.workspace.theme = "breeze-dark";

  programs.plasma.panels = [
    {
      screen = "all";
    }
  ];

  programs.plasma.powerdevil = {
    AC = {
      autoSuspend =
        if passthru.exssd == true then
          {
            action = "nothing";
          }
        else
          {
            action = "sleep";
            idleTimeout = 900;
          };
    };
  };

  programs.konsole = {
    enable = true;
    defaultProfile = "Nushell.profile";
    profiles = {
      "Nushell" = {
        command = lib.getExe config.programs.nushell.package;
      };
      "Zsh" = {
        command = lib.getExe config.programs.zsh.package;
      };
      "Anime" = {
        command = "ani-cli";
      };
    };
  };
}
