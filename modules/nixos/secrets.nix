{ flake, pkgs, ... }:
let
  inherit (flake) inputs config;
  inherit (inputs) self;
in
{
  imports = [
    inputs.sops-nix.nixosModules.sops
  ];

  sops.defaultSopsFile = "${self}/secrets/secrets.yaml";
  sops.defaultSopsFormat = "yaml";
  sops.age.keyFile = "/home/${config.me.username}/.config/sops/age/keys.txt";
  sops.secrets = {
    example-key = { };
    "myservice/my_subdir/my_secret" = { };
    "anki/secret" = { };
  };

  environment.systemPackages = with pkgs; [
    sops
  ];
}
