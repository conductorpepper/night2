{ lib, ... }: {
  options.utils.monitors = {
    monitors = lib.mkOption {
      description = "List of monitors";
      longDescription = "List of monitors. The first monitor is considered primary.";
      type = lib.types.listOf lib.types.str;
      default = [];
    };
  };
}
