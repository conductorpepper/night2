{
  config,
  pkgs,
  lib,
  ...
}: let
  cfg = config.bundles.jellyfin;
in {
  options.bundles.jellyfin = let
    inherit (lib) mkEnableOption;
  in {
    enable = mkEnableOption "Jellyfin bundle";
  };

  config = lib.mkIf cfg.enable {
    services.jellyfin.enable = true;
    services.jellyfin.openFirewall = true;
    services.jellyseerr.enable = true;

    environment.systemPackages = with pkgs; [
      jellyfin
      jellyfin-web
      jellyfin-ffmpeg
    ];
  };
}
