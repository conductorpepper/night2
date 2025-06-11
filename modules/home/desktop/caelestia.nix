{
  flake,
  pkgs,
  lib,
  ...
}:
{
  xdg.configFile."quickshell/caelestia".source = pkgs.fetchFromGitHub {
    owner = "caelestia-dots";
    repo = "shell";
    rev = "bef79bde1f56d42e551424ffb061fe3f76fe5ea6";
    hash = "sha256-/+R8UfKhEogRq94WLIC8nWmKgDdadXSoKQqLQkeBPTY=";
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
    ++ (with pkgs.python313Packages; [
      aubio
      pyaudio
      numpy
    ]);
}
