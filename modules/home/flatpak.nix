{flake, ...}: {
  imports = [
    flake.inputs.nix-flatpak.homeManagerModules.nix-flatpak
  ];

  services.flatpak.enable = true;
  services.flatpak.packages = [
    "org.vinegarhq.Sober"
  ];

  services.flatpak.update.auto = {
    enable = true;
    onCalendar = "weekly";
  };
}
