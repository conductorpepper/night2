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
      umu-launcher
      feishin # jellyfin client (music)
      gale # thunderstore client
      komikku # comic/manga reader
      everest-mons # celeste mods
      prismlauncher # minecraft
      sm64coopdx
      (tetrio-desktop.override {withTetrioPlus = true;})
    ]
    ++ (with inputs.nyxexprs.packages.${system}; [
      ani-cli
    ]);
}
