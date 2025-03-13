{
  perSystem = {pkgs, ...}: {
    packages = with pkgs; {
      middle-mann-fonts = callPackage ../../packages/middle-mann-fonts.nix {};
    };
  };
}
