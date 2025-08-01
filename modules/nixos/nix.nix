{
  flake,
  config,
  pkgs,
  ...
}:
let
  inherit (flake) inputs;
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
      "electron-34.5.8"

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
      flake.config.me.username
    ];
  };

  # garbage collection
  nix = {
    optimise = {
      automatic = true;
      dates = "weekly";
    };
  };

  programs.nh = {
    enable = true;
    flake = "/etc/night2";
    clean = {
      enable = true;
      extraArgs = "--keep-since 7d --keep 3";
    };
  };

  environment.systemPackages =
    with pkgs;
    let
      nh =
        sub:
        (writeShellScriptBin "night2-${sub}" ''
          nh os ${sub} ${config.programs.nh.flake}
        '');
    in
    [
      nix-output-monitor

      (writeShellScriptBin "night2-activate" ''
        nix run ${config.programs.nh.flake}#activate
      '')

      (nh "switch")
      (nh "boot")
      (nh "test")
    ];
}
