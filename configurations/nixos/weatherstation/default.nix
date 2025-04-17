{flake, ...}: {
  imports = [
    flake.inputs.self.nixosModules.default
    ./hardware-configuration.nix
  ];

  networking.hostName = "weatherstation";
  time.timeZone = "America/New_York";
  system.stateVersion = "25.05";

  bundles.jellyfin.enable = true;
  utils.exssd.enable = true;

  # i have another operating system i REALLY don't want to overwrite
  # so i'll just do this (and disable the disks in bios)
  utils.disk = {
    enable = true;
    device = "/dev/disk/by-partlabel/disk-main-root";
  };
}
