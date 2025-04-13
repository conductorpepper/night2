{flake, ...}: {
  imports = [
    flake.inputs.nix-flatpak.homeManagerModules.nix-flatpak
  ];

  services.flatpak.enable = true;
  services.flatpak.packages = [
    "com.dec05eba.gpu_screen_recorder" # move to nixos when the module is done
    "org.vinegarhq.Sober"
  ];

  services.flatpak.update.auto = {
    enable = true;
    onCalendar = "weekly";
  };
}
