{ pkgs, lib, ... }:
{
  xdg.configFile."quickshell/caelestia".source = pkgs.fetchFromGitHub {
    owner = "caelestia-dots";
    repo = "shell";
    rev = "ea4d3f26ef438b8075d9ea1aa3f297173d6cd58d";
    hash = lib.fakeHash;
  };
}
