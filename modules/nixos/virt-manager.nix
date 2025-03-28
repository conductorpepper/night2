{
  config,
  pkgs,
  lib,
  ...
}: let
  cfg = config.bundles.virt-manager;
in {
  options.bundles.virt-manager = let
    inherit (lib) mkEnableOption;
  in {
    enable = mkEnableOption "virt-manager bundle";
  };

  config = lib.mkIf cfg.enable {
    virtualisation.libvirtd.enable = true;
    virtualisation.spiceUSBRedirection.enable = true;

    services.qemuGuest.enable = true;
    services.spice-vdagentd.enable = true;
    services.spice-webdavd.enable = true;

    programs.virt-manager.enable = true;
    environment.systemPackages = with pkgs; [
      spice
      virt-viewer
    ];
  };
}
