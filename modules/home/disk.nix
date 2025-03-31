# i have literally no idea what i'm doing
# :3
{
  config,
  lib,
  flake,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
  inherit (flake) inputs;
  cfg = config.utils.disk;
in {
  imports = [
    inputs.impermanence.homeManagerModules.impermanence
  ];

  options.utils.disk = {
    enable = mkEnableOption "automatic disko + impermanence configuration";
    longDescription = ''
      Sets up my preferred Disko and Impermanence configuration.

      Disko is used for delcarative disk management,
      and Impermanence is used to clean up my system.
    '';
  };

  config = mkIf cfg.enable {
    home.persistence."/persistent/home/${flake.config.utils.user.username}" = {
      directories = let
        config = name: ".config/${name}";
        share = name: ".local/share/${name}";
        shareSym = name: {
          directory = share name;
          method = "symlink";
        };
      in [
        "Documents"
        "Pictures"
        "Videos"
        "VirtualBox VMs"
        "Music"
        ".gnupg"
        ".betacraft"
        ".zen"

        (config "keepassxc") # keeshare is menacing
        (config "OpenTabletDriver") # this can be declarative
        (config "gpu-screen-recorder") # can also be declarative
        (config "com.kesomannen.gale") # can also be declarative

        (share "keyrings")
        (share "direnv")
        (share "Anki2")
        (share "Celeste")
        (share "DaVinciResolve")
        (share "komikku")
        (share "lutris")
        (share "gg.essential.mod")
        (share "godot")
        (share "kiwix")
        (shareSym "Steam")
      ];

      files = [];

      allowOther = true;
    };
  };

  utils.disk.enable = true; # yeah.
}
