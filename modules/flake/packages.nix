{
  perSystem = {pkgs, ...}: {
    packages = let
      # THE HORROR THE TERROR OF .nix, EVISCERATING THE COLORS
      package = name: (pkgs.callPackage ../../packages/${name}.nix {});
    in {
      middle-mann-fonts = package "middle-mann-fonts";
    };
  };
}
