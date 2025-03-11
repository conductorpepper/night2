{pkgs, ...}: {
  programs.xfconf.enable = true;

  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
  ];

  qt.enable = true;
  qt.platformTheme = "qt5ct";

  xdg.portal.enable = true;
  xdg.portal.wlr.enable = true;
  xdg.portal.config = {
    common = {
      default = ["hyprland" "gtk"];
    };
  };

  xdg.mime.enable = true;
  programs.dconf.enable = true;

  environment.systemPackages = with pkgs; [
    nautilus
  ];
}
