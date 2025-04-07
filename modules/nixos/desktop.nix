{
  flake,
  pkgs,
  ...
}: let
  inherit (flake) inputs;
  inherit (inputs) self;
in {
  # dewm
  programs.hyprland.enable = true;
  programs.hyprland.withUWSM = true;
  programs.uwsm = {
    enable = true;
  };

  # greeter
  services.displayManager = {
    enable = true;
    sddm = {
      enable = true;
      wayland.enable = true;
      theme = "hyprland_kath";
      extraPackages = with pkgs.kdePackages; [
        qtmultimedia
        qtsvg
        qtvirtualkeyboard
      ];
    };
  };

  # desktop utils
  programs.hyprlock.enable = true;
  services.hypridle.enable = true;

  # fonts
  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
  ];

  # qt
  qt.enable = true;
  qt.platformTheme = "qt5ct";

  # xdg portal
  xdg.portal.enable = true;
  xdg.portal.wlr.enable = true;
  xdg.portal.config = {
    common = {
      default = ["hyprland" "gtk"];
    };
  };

  # conf
  programs.xfconf.enable = true;
  programs.dconf.enable = true;

  # whatever this is
  services.xserver.updateDbusEnvironment = true;

  # utility packages
  environment.systemPackages = with pkgs; [
    nemo-with-extensions

    (self.packages.${pkgs.stdenv.hostPlatform.system}.sddm-astronaut-theme.override {
      theme = "hyprland_kath";
    })
  ];
}
