{
  flake,
  config,
  lib,
  ...
}:
let
  cfg = config.bundles.docker;
in
{
  options.bundles.docker =
    let
      inherit (lib) mkEnableOption;
    in
    {
      enable = mkEnableOption "Docker bundle";
    };

  config = lib.mkIf cfg.enable {
    virtualisation.docker.rootless = {
      enable = true;
      setSocketVariable = true;
      daemon.settings = {
        pruning = {
          enabled = true;
          interval = "24h";
        };
      };
    };
  };
}
