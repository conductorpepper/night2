{
  lib,
  config,
  pkgs,
  ...
}: {
  # backlight
  hardware.brillo.enable = true;

  # networking
  networking.networkmanager.enable = true;
  services.gnome = {
    glib-networking.enable = true;
    at-spi2-core.enable = true;
  };

  # bluetooth
  hardware.bluetooth.enable = true;

  # graphics
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      intel-compute-runtime
      intel-media-driver
      vpl-gpu-rt
      rocmPackages.clr.icd
    ];
  };

  hardware.opentabletdriver.enable = true; # for my huion :3

  # audio
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # storage
  services.udisks2.enable = true;
  services.gvfs.enable = true;
  programs.gnome-disks.enable = true;

  # touch
  services.touchegg.enable = true;

  # power
  services.upower.enable = lib.mkDefault config.powerManagement.enable;

  # input
  services.libinput.enable = true;

  # color
  services.colord.enable = true;

  # biometrics
  services.fprintd.enable = true;

  # printers
  services.printing.enable = true;
  services.printing.drivers = with pkgs; [
    gutenprint
    gutenprintBin
    hplip
    hplipWithPlugin
    cnijfilter2
  ];

  # scanners
  hardware.sane.enable = true;

  # discovery (which whether i can rebuild in place or not rests on a coin flip)
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  # utility packages
  environment.systemPackages = with pkgs; [
    veracrypt

    pavucontrol
    pamixer

    system-config-printer
    simple-scan
  ];
}
