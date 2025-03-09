{pkgs, ...}: {
  # backlight
  hardware.brillo.enable = true;

  # networking
  networking.networkmanager.enable = true;
  networking.wireless = {
    enable = true;
    userControlled.enable = true;
  };

  # bluetooth
  hardware.bluetooth.enable = true;
  environment.systemPackages = with pkgs; [
    pavucontrol
  ];

  # graphics
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      intel-compute-runtime
      intel-media-driver
      vpl-gpu-rt
    ];
  };

  hardware.opentabletdriver.enable = true; # for my huion :3

  # audio
  security.rtkit.enable = true;
  hardware.pulseaudio.enable = true;
}