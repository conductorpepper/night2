{ pkgs, ... }:
{
  # dewm
  services.desktopManager.plasma6 = {
    enable = true;
  };
  programs.kdeconnect.enable = true;

  # greeter
  services.displayManager = {
    enable = true;
    sddm = {
      enable = true;
      wayland.enable = true;
      # package = pkgs.kdePackages.sddm;
      theme = "sddm-astronaut-theme";
      extraPackages = with pkgs.kdePackages; [
        qtmultimedia
        qtsvg
        qtvirtualkeyboard
      ];
    };
  };

  # fonts
  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
  ];

  # qt
  qt.enable = true;
  qt.platformTheme = "kde6";

  # xdg portal
  xdg.portal.enable = true;
  xdg.portal.wlr.enable = true;
  xdg.portal.extraPortals = with pkgs; [
    xdg-desktop-portal-gtk
  ];
  xdg.portal.config = {
    common = {
      default = [
        "gtk"
      ];
    };
  };

  # conf
  programs.xfconf.enable = true;
  programs.dconf.enable = true;

  # whatever this is
  services.xserver.updateDbusEnvironment = true;

  # polkit
  security.polkit.enable = true;

  # utility packages
  environment.systemPackages = with pkgs; [
    # nemo-with-extensions
    lxqt.lxqt-policykit

    # ...?
    (callPackage ./pkg/sddm-astronaut-theme.nix {
      theme = "hyprland_kath";
    })
  ];
}
