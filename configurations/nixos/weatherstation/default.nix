{ flake, ... }:
{
  imports = [
    flake.inputs.self.nixosModules.default
    ./hardware-configuration.nix
  ];

  networking.hostName = "weatherstation";
  time.timeZone = "America/New_York";
  system.stateVersion = "25.05";

  bundles.jellyfin.enable = true;
  bundles.tailscale.enable = true;
  bundles.tailscale.key = "tskey-auth-k2dr2qArg521CNTRL-RE6UF8ETaC9AdifA3BnnC9UmRXeaRxZtY"; # single-use
  bundles.power.enable = true;
  bundles.docker.enable = true;
  bundles.krdp.enable = false;
  virtualisation.docker.storageDriver = "btrfs";
  utils.exssd.enable = true;
  utils.monitors.monitors = [
    "HDMI-A-1"
    "DP-3"
  ];

  # i have another operating system i REALLY don't want to overwrite
  # so i'll just do this (and disable the disks in bios)
  utils.disk = {
    enable = true;
    device = "/dev/disk/by-partlabel/disk-main-root";
    swap = "16G";
  };
}
