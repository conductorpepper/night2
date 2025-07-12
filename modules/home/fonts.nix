{
  flake,
  pkgs,
  ...
}:
let
  inherit (flake) inputs;
in
{
  home.packages =
    let
      system = pkgs.stdenv.hostPlatform.system;

      used-nerd-fonts = with pkgs.nerd-fonts; [
        jetbrains-mono
      ];

      lemon-fonts = with inputs.nix-lemons.packages.${system}; [
        middle-mann-fonts
      ];
    in
    with pkgs;
    [
      # fonts
      roboto
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
      inter
      commit-mono
      cozette
      tewi-font
      terminus_font
      hack-font
    ]
    ++ used-nerd-fonts
    ++ lemon-fonts;
}
