{
  flake,
  config,
  ...
}: let
  inherit (flake.inputs) self;
  inherit (flake.config) me;
in {
  imports = [
    {
      home-manager.users.${me.username} = {
        home.stateVersion = config.system.stateVersion;
      };
      home-manager.sharedModules = [
        self.homeModules.default
      ];
      home-manager.extraSpecialArgs.passthru = {
        exssd = config.utils.exssd.enable;
      };
    }
  ];
}
