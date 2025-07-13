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
    programs.virt-manager.enable = true;
    virtualisation.libvirtd.enable = true;
    virtualisation.spiceUSBRedirection.enable = true;
    services.qemuGuest.enable = true;
    services.spice-vdagentd.enable = true;
    services.spice-webdavd.enable = true;

    # since it decreases performance (probably),
    # disable CoW for the vm images
    system.activationScripts.libvirtcow = {
      text = ''
        mkdir -p /var/lib/libvirt/images
        ${pkgs.busybox}/bin/chattr +C /var/lib/libvirt/images
      '';
    };

    environment.systemPackages = with pkgs; [
      spice
      virt-viewer
    ];
  };
}
