{
  lib,
  flake,
  config,
  ...
}: let
  cfg = config.bundles.virtualbox;
in {
  options.bundles.virtualbox = let
    inherit (lib) mkEnableOption;
  in {
    enable = mkEnableOption "virtualbox bundle";
  };

  config = lib.mkIf cfg.enable {
    virtualisation.virtualbox.host.enable = true;
    virtualisation.virtualbox.host.enableExtensionPack = true;
    virtualisation.virtualbox.guest.enable = true;
    virtualisation.virtualbox.guest.dragAndDrop = true;

    users.extraGroups.vboxusers.members = [
      flake.config.utils.user.username
    ];
  };
}
