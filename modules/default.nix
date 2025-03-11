{
  flake.nixosModules = {
    jellyfin = import ./jellyfin.nix;
    power = import ./power.nix;
  };

  flake.homeModules = {
    exssd = import ./exssd.nix;
    swww = import ./swww.nix;
  };
}
