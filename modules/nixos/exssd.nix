{
  config,
  lib,
  ...
}: let
  inherit (lib) mkEnableOption;
  cfg = config.utils.exssd;
in {
  options.utils.exssd = {
    enable = mkEnableOption "external ssd utilities";
    longDescription = ''
      Indicates that an external SSD is in use for this machine.

      Some programs do not work well with an external SSD.
      In particular, `systemctl suspend` (as of 23.11) shuts down
      the operating system after a random amount of time
      (and the filesystem has to look at its journal).

      This module exposes an environment variable named EXSSD,
      which is `true` if the module is enabled.
    '';
  };

  config = {
    # i'm not sure if this will work without --impure,
    # but i'll know when i know.
    # alternatively, i can add an option in `config-module.nix`
    # and make a list of machines that do rely on an external ssd.
    environment.variables.EXSSD =
      if cfg.enable
      then "true"
      else "false";
  };
}
