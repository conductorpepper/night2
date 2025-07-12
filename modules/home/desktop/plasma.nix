{ flake, ... }:
{
  imports = [
    flake.inputs.plasma-manger.homeManagerModules.plasma-manager
  ];
}
