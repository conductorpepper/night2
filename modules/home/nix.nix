{
  flake,
  pkgs,
  ...
}: {
  imports = [
    flake.inputs.nix-index-database.hmModules.nix-index
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
    # does the $1 screw this up?
    (writeShellScriptBin "nix-prefetch-hash" ''
      nix hash to-sri --type sha256 $(nix-prefetch-url --unpack "$1")
    '')
  ];
}
