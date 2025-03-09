{
  imports = [
    ./hardware-configuration.nix
  ];

  networking.hostName = "allision";
  time.timeZone = "America/New_York";
  system.stateVersion = "25.05";
}