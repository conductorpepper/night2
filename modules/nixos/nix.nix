{ flake, pkgs, ... }:
let
  inherit (flake) config inputs;
in
{
  imports = [
    inputs.lix-module.nixosModules.default
  ];

  # nixpkgs config
  nixpkgs.config = {
    allowUnfree = true;
    permittedInsecurePackages = [
      # temporary due to EOL
      "dotnet-runtime-6.0.36"
      "dotnet-sdk-wrapped-6.0.428"
      "dotnet-sdk-6.0.428"

      # logseq EOL
      "electron-27.3.11"
      "electron-31.7.7"
      "electron-33.4.11"

      # for trenchbroom; why. like, the ACEs!!! WHY!!!
      "freeimage-3.18.0-unstable-2024-04-18"
      "freeimage-unstable-2021-11-01"
    ];
  };

  # substituers (and experimental-features)
  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];
    auto-optimise-store = true;

    substituters = [
      "https://nyx.cachix.org"
    ];

    trusted-public-keys = [
      "nyx.cachix.org-1:xH6G0MO9PrpeGe7mHBtj1WbNzmnXr7jId2mCiq6hipE="
    ];

    trusted-users = [
      "root"
      config.me.username
    ];
  };

  # garbage collection
  nix = {
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 14d";
    };

    optimise = {
      automatic = true;
      dates = [ "04:00" ];
    };
  };

  environment.systemPackages = with pkgs; [
    (writeShellScriptBin "night2-activate" ''
      sudo nix run /etc/night2#activate
    '')
  ];
}
