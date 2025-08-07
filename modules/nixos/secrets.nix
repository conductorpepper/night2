{
  flake,
  pkgs,
  ...
}:
let
  inherit (flake) inputs;
  inherit (inputs) self;
in
{
  imports = [
    inputs.sops-nix.nixosModules.sops
  ];

  sops.defaultSopsFile = "${self}/secrets/secrets.yaml";
  sops.defaultSopsFormat = "yaml";
  sops.age.keyFile = "/home/${flake.config.me.username}/.config/sops/age/keys.txt";
  sops.secrets = {
    "anki/email" = { };
    "anki/sync" = { };
  };

  # and then useful utilities
  environment.systemPackages = with pkgs; [
    sops
  ];
}
