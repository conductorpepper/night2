{
  config,
  lib,
  ...
}: let
  cfg = config.bundles.power;
in {
  options.bundles.power = let
    inherit (lib) mkEnableOption;
  in {
    enable = mkEnableOption "power bundle";
  };

  config = lib.mkIf cfg.enable {
    services.power-profiles-daemon.enable = true;
  };
}
