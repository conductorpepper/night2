{pkgs, ...}: {
  xdg.portal.enable = true;
  xdg.portal.extraPortals = with pkgs; [
    xdg-xdg-desktop-portal-gtk
  ];
  xdg.portal.config = {
    common = {
      default = ["hyprland" "gtk"];
    };
  };
}
