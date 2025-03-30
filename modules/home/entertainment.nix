{
  flake,
  pkgs,
  ...
}: let
  inherit (flake) inputs;
  system = pkgs.stdenv.hostPlatform.system;
in {
  services.arrpc.enable = true;

  home.packages = with pkgs;
    [
      # chat
      vesktop
      signal-desktop
      deltachat-desktop

      # games
      lutris
      feishin # jellyfin client
      gale # thunderstore client
      komikku # comic/manga reader
      everest-mons # celeste mods
      prismlauncher # minecraft
      (tetrio-desktop.override {withTetrioPlus = true;})
    ]
    ++ (with inputs.nyxexprs.packages.${system}; [
      ani-cli
    ])
    ++ (with inputs.nix-lemons.packages.${system}; [
      betacraft-launcher-bin
    ]);
}
