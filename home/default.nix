{self, ...}: {
  imports = [
    self.nixosModules.swww
    ./dev.nix
    ./productivity.nix
  ];

  home = {
    username = "ri";
    homeDirectory = "/home/ri";
    stateVersion = "25.05";
  };

  programs.home-manager.enable = true;
}
