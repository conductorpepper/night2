{lib, ...}: let
  inherit (lib) mkOption types;
in {
  options.utils.user = {
    username = mkOption {
      type = types.str;
    };

    fullname = mkOption {
      type = types.str;
    };

    email = mkOption {
      type = types.str;
    };
  };
}
