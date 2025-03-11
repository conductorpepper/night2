{
  flake.nixosModules = {
    jellyfin = import ./jellyfin.nix;
    power = import ./power.nix;
    swww = import ./swww.nix;
  };
}
