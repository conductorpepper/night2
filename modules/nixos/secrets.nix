{ flake, ... }:
let
  inherit (flake) inputs;
in
{
  imports = [
    inputs.sops-nix.nixosModules.sops
  ];
}
