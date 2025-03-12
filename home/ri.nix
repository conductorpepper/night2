{flake, ...}: let
  inherit (flake.inputs) self;
  inherit (flake.config) utils;
in {
  imports = [
    self.homeModules.default
  ];

  home = {
    username = utils.user.username;
    homeDirectory = "/home/${utils.user.username}";
    stateVersion = "25.05";
  };
}
