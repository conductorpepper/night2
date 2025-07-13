{ lib, ... }: {
  options.utils.monitors = {
    monitors = lib.mkOption {
      description = "List of monitors";
      type = lib.types.listOf lib.types.str;
      default = [];
    };
  };
}
