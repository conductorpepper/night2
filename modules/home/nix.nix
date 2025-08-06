{
  flake,
  pkgs,
  ...
}:
{
  imports = [
    flake.inputs.nix-index-database.homeModules.nix-index
  ];

  nix = {
    gc = {
      automatic = true;
      frequency = "weekly";
    };
  };

  programs.nix-index = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.direnv = {
    # shell integrations already handled in ./dev.nix
    enable = true;
    nix-direnv.enable = true;
  };

  home.packages = with pkgs; [
    nix-output-monitor
    comma
    statix
    nix-prefetch
    nix-melt
  ];
}
