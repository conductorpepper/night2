{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}: {
  imports = [
    (modulesPath + "/installer/cd-dvd/installation-cd-minimal.nix")
  ];

  boot.initrd.availableKernelModules = ["xhci_pci" "ahci" "usbhid" "uas" "sd_mod" "sr_mod"];
  boot.initrd.kernelModules = [];
  boot.kernelModules = ["kvm-intel"];
  boot.extraModulePackages = [];

  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = ["nix-command" "flakes"];

  networking.hostName = "prelude";
  networking.networkmanager.enable = true;
  networking.wireless.enable = false;

  time.timeZone = "America/New_York";

  environment.systemPackages = with pkgs; [
    # TODO: add bin path
    (writeShellApplication {
      name = "night2-install";
      runtimeInputs = with pkgs; [nushell git networkmanager gum];
      text = ''
        nu ${./install.nu}
      '';
    })

    git
    gh
    neovim
    wget
    curl
    btop
    tmux
    ranger
  ];

  networking.useDHCP = lib.mkDefault true;
  nixpkgs.hostPlatform = "x86_64-linux";
  system.stateVersion = "25.05";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
