{
  programs = {
    direnv = {
      # shell integrations already handled in ./dev.nix
      enable = true;
      nix-direnv.enable = true;
    };
  };
}
