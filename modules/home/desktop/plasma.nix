{ flake, ... }:
{
  imports = [
    flake.inputs.plasma-manager.homeManagerModules.plasma-manager
  ];
}
