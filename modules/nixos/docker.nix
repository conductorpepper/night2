# it's podman.
{
  flake,
  config,
  pkgs,
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
    virtualisation.containers = {
      enable = true;
      storage.settings = {
        storage = {
          driver = "btrfs";
          graphroot = "/var/lib/containers/storage";
          runroot = "/run/containers/storage";
        };
      };
    };

    virtualisation.podman = {
      enable = true;
      dockerCompat = true;
      defaultNetwork.settings.dns_enabled = true;
      autoPrune.enable = true;
    };

    users.users.${flake.config.me.username}.extraGroups = [ "podman" ];

    environment.systemPackages = with pkgs; [
      podman-tui
    ];
  };
}
