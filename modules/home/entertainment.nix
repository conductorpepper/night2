{
  flake,
  pkgs,
  ...
}:
let
  inherit (flake) inputs;
  system = pkgs.stdenv.hostPlatform.system;
in
{
  services.arrpc.enable = true;

  home.packages =
    with pkgs;
    [
      # chat
      vesktop
      signal-desktop
      deltachat-desktop

      # social
      tuba
      kdePackages.tokodon

      # games
      lutris
      umu-launcher
      feishin # jellyfin client (music)
      gale # thunderstore client
      komikku # comic/manga reader
      everest-mons # celeste mods
      prismlauncher # minecraft
      mcpelauncher-ui-qt # mc bedrock
      # sm64coopdx # since it requires a rom in the nix store; easier to `nix run`
      (tetrio-desktop.override { withTetrioPlus = true; })

      # video
      grayjay
    ]
    ++ (with inputs.nyxexprs.packages.${system}; [
      ani-cli
    ]);
}
