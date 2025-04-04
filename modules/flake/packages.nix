{
  perSystem = {pkgs, ...}: {
    packages = let
      # THE HORROR THE TERROR OF .nix, EVISCERATING THE COLORS
      package = name: (pkgs.callPackage ../../packages/${name}.nix {});
    in {
      sddm-astronaut-theme = package "sddm-astronaut-theme";
    };
  };
}
