{
  imports = [
    ./hardware-configuration.nix
  ];

  networking.hostName = "keeper";
  time.timeZone = "America/New_York";
  system.stateVersion = "25.05";

  nixos-unified.sshTarget = "ri@keeper";
}
