{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.bundles.krdp;
in
{
  options.bundles.krdp =
    let
      inherit (lib) mkEnableOption;
    in
    {
      enable = mkEnableOption "krdp bundle";
    };

  config = lib.mkIf cfg.enable {
    networking.firewall.allowedUDPPorts = [ 3389 ];
    environment.systemPackages = with pkgs; [
      kdePackages.krdp
    ];
  };
}
