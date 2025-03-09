{inputs, ...}: {
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

      # for trenchbroom; why. like, the ACEs!!! WHY!!!
      "freeimage-unstable-2021-11-01"
    ];
  };

  # substituers (and experimental-features)
  nix.settings = {
    experimental-features = ["nix-command" "flakes"];
    auto-optimise-store = true;

    substituters = [
      "https://hyprland.cachix.org"
      "https://anyrun.cachix.org"
      "https://wezterm.cachix.org"
    ];

    trusted-public-keys = [
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      "anyrun.cachix.org-1:pqBobmOjI7nKlsUMV25u9QHa9btJK65/C8vnO3p346s="
      "wezterm.cachix.org-1:kAbhjYUC9qvblTE+s7S+kl5XM1zVa4skO+E/1IDWdH0="
    ];
  };

  # garbage collection
  nix = {
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };

    optimise = {
      automatic = true;
      dates = ["04:00"];
    };
  };

  # lix
  nix.package = pkgs.lix;
}