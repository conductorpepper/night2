{inputs, ...}: {
  imports = with inputs.nixos-unified; [
    default
    autoWire
  ];

  perSystem = {
    self',
    inputs',
    pkgs,
    ...
  }: {
    formatter = inputs'.nyxexprs.packages.alejandra-custom;
    packages.default = self'.packages.activate;
  };
}
