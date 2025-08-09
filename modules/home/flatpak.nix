{ flake, ... }:
{
  imports = [
    flake.inputs.nix-flatpak.homeManagerModules.nix-flatpak
  ];

  services.flatpak.enable = true;
  services.flatpak.packages = [
    "org.vinegarhq.Sober"
    "org.vinegarhq.Vinegar"
    "com.github.tchx84.Flatseal"
    "com.voxdsp.TuxFishing"
  ];

  services.flatpak.update.auto = {
    enable = true;
    onCalendar = "weekly";
  };
}
