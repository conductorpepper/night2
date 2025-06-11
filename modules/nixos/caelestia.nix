{ flake, pkgs, ... }:
{
  programs.git.enable = true;
  programs.fish.enable = true;
  networking.networkmanager.enable = true;
  hardware.bluetooth.enable = true;

  fonts.packages = with pkgs; [
    material-symbols
    ibm-plex
    nerd-fonts.jetbrains-mono
  ];

  # TODO: add app2unit when i can use it
  environment.systemPackages =
    (with pkgs; [
      flake.inputs.quickshell.packages.${pkgs.stdenv.hostPlatform.system}.default
      qt6.qtdeclarative
      curl
      jq
      fd
      cava
      ddcutil
      brightnessctl
      imagemagick
    ])
    ++ (with pkgs.python313Packages; [
      aubio
      pyaudio
      numpy
    ]);
}
