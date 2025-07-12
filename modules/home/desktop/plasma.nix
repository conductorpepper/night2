{
  flake,
  lib,
  config,
  ...
}:
{
  imports = [
    flake.inputs.plasma-manager.homeManagerModules.plasma-manager
  ];

  programs.konsole = {
    enable = true;
    defaultProfile = "Nushell";
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
