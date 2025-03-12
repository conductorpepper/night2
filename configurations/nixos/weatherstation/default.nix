{
  imports = [
    ./hardware-configuration.nix
  ];

  networking.hostName = "weatherstation";
  time.timeZone = "America/New_York";
  system.stateVersion = "25.05";

  nixos-unified.sshTarget = "ri@weatherstation";
}
