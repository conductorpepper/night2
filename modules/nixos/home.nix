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
        xdg.configFile."night2-passthru.json".text = builtins.toJSON {
          exssd =
            if config.utils.exssd.enable
            then true
            else false;
        };
      };
      home-manager.sharedModules = [
        self.homeModules.default
      ];
    }
  ];
}
