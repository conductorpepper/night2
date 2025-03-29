{
  flake,
  config,
  ...
}: {
  imports = [
    flake.inputs.self.nixosModules.default
  ];

  networking.hostName = "keeper";
  time.timeZone = "America/New_York";
  system.stateVersion = "25.05";

  boot.initrd.availableKernelModules = ["xhci_pci" "ahci" "usbhid" "uas" "sd_mod" "sr_mod"];
  boot.initrd.kernelModules = [];
  boot.kernelModules = ["kvm-intel"];
  boot.extraModulePackages = [];

  networking.useDHCP = true;
  hardware.cpu.intel.updateMicrocode = config.hardware.enableRedistributableFirmware;

  utils.disk = {
    enable = true;
    device = "/dev/vda";
  };

  nixpkgs.hostPlatform = "x86_64-linux";
}
