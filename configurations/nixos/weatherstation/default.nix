{flake, ...}: {
  imports = [
    flake.inputs.self.nixosModules.default
    ./hardware-configuration.nix
  ];

  networking.hostName = "weatherstation";
  time.timeZone = "America/New_York";
  system.stateVersion = "25.05";

  bundles.jellyfin.enable = true;

  # i have another operating system i REALLY don't want to overwrite
  # so i'll just do this (and disable the disks in bios)
  utils.disk = {
    enable = true;
    device = "/dev/disk/by-uuid/5d4f75e2-289c-41f1-bdba-1a2474d5cc97";
  };
}
