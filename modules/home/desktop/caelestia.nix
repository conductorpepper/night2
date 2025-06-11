{ flake, pkgs, ... }:
{
  xdg.configFile."quickshell/caelestia".source = pkgs.fetchFromGitHub {
    owner = "caelestia-dots";
    repo = "shell";
    rev = "ea4d3f26ef438b8075d9ea1aa3f297173d6cd58d";
    hash = "sha256-rh4Cu24uZoArFBYJhREGPkwTFTA9Q2GeGjdOTu9WhgA=";
  };

  programs.git.enable = true;
  programs.fish.enable = true;

  # TODO: add app2unit when i can use it
  home.packages =
    [
      flake.inputs.quickshell.packages.${pkgs.stdenv.hostPlatform.system}.default
    ]
    ++ (with pkgs; [
      material-symbols
      nerd-fonts.jetbrains-mono
      ibm-plex
      curl
      jq
      fd
      cava
      bluez
      ddcutil
      brightnessctl
      imagemagick
    ])
    ++ (with pkgs.pythonPackages; [
      aubio
      pyaudio
      numpy
    ]);
}
