{
  perSystem = {
    config,
    inputs',
    system,
    ...
  }: {
    _modules.args.pkgs = import inputs'.nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };
  };
}
