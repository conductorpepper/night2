{
  perSystem = {
    config,
    self',
    inputs',
    pkgs,
    system,
    ...
  }: {
    # Per-system attributes can be defined here. The self' and inputs'
    # module parameters provide easy access to attributes of the same
    # system.

    devShells.default = pkgs.mkShell {
      packages = with pkgs; [
        inputs'.nyxexprs.packages.alejandra-custom # formatter
        nil # lsp

        git
        just

        sl # test
      ];

      name = "night2-shell";
    };
  };
}
