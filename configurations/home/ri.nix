{flake, ...}: let
  inherit (flake.inputs) self;
  inherit (flake.config) me;
in {
  imports = [
    self.homeModules.default
  ];

  home = {
    username = me.username;
    homeDirectory = "/home/${me.username}";
    stateVersion = "25.05";
  };

  programs.home-manager.enable = true; # i forgo
}
