{flake, ...}: let
  inherit (flake.inputs) self;
  inherit (flake.config) me;
in {
  imports = [
    {
      home-manager.users.${me.username} = {};
      home-manager.sharedModules = [
        self.homeModules.default
      ];
    }
  ];
}
