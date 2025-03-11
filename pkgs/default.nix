{
  perSystem = {pkgs, ...}: {
    packages = with pkgs; {
      middle-mann-fonts = callPackage ./middle-mann-fonts.nix {};
    };
  };
}
