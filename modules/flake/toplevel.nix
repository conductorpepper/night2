{inputs, ...}: {
  imports = with inputs.nixos-unified.flakeModules; [
    default
    autoWire
  ];

  perSystem = {
    self',
    pkgs,
    ...
  }: {
    packages.default = self'.packages.activate;
  };
}
