{ flake, ... }:
let
  inherit (flake) inputs;
in
{
  imports = [
    inputs.sops-nix.homeManagerModules.sops
  ];
}
