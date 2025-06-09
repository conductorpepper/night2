{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.bundles.tailscale;
in
{
  options.bundles.tailscale =
    let
      inherit (lib) mkOption mkEnableOption;
    in
    {
      enable = mkEnableOption "Tailscale bundle";
      key = mkOption {
        type = lib.types.str;
        description = "auth key; unless it's a secret, preferably single-use";
      };
    };

  config = lib.mkIf cfg.enable {
    services.tailscale.enable = true;

    environment.systemPackages = with pkgs; [
      tailscale
    ];

    systemd.services.tailscale-autoconnect = {
      description = "Automatic connection to Tailscale";

      after = [
        "network-pre.target"
        "tailscaled.service"
      ];
      wants = [
        "network-pre.target"
        "tailscaled.service"
      ];
      wantedBy = [
        "multi-user.target"
      ];

      serviceConfig.Type = "oneshot";

      script =
        let
          tailscale = lib.getExe config.services.tailscale.package;
          jq = lib.getExe pkgs.jq;
        in
        ''
          sleep 2

          status="$(${tailscale} status -json | ${jq} -r .BackendState)"
          if [ $status = "Running" ]; then
            exit 0
          fi

          ${tailscale} up -authkey ${cfg.key}
        '';
    };

    networking.firewall = {
      enable = true;
      trustedInterfaces = [ "tailscale0" ];
      allowedUDPPorts = [ config.services.tailscale.port ];
    };
  };
}
