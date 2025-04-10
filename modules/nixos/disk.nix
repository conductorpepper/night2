# i have literally no idea what i'm doing
# :3
{
  config,
  lib,
  flake,
  ...
}: let
  inherit (lib) mkEnableOption mkOption mkIf types;
  inherit (flake) inputs;
  cfg = config.utils.disk;
in {
  imports = [
    inputs.disko.nixosModules.disko
  ];

  options.utils.disk = {
    enable = mkEnableOption "automatic disko configuration";
    longDescription = ''
      Sets up my preferred Disko configuration.

      Disko is used for delcarative disk management,
      and Impermanence is used to clean up my system.
    '';
    device = mkOption {
      type = types.str;
    };
  };

  config = mkIf cfg.enable {
    disko.devices = {
      disk.main = {
        type = "disk";
        inherit (cfg) device;
        content = {
          type = "gpt";
          partitions = {
            esp = {
              size = "512M";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = ["umask=0077"];
              };
            };
            root = {
              size = "100%";
              content = {
                type = "luks";
                name = "crypted";
                passwordFile = "/tmp/secret.key";
                settings = {
                  allowDiscards = true;
                };
                content = {
                  type = "btrfs";
                  extraArgs = ["-f"];
                  subvolumes = let
                    mountOptions = ["compress=zstd" "noatime"];
                  in {
                    "@" = {
                      mountpoint = "/";
                      inherit mountOptions;
                    };
                    "@swap" = {
                      mountpoint = "/.swapvol";
                      swap.swapfile.size = "20M";
                    };
                  };
                };
              };
            };
          };
        };
      };
    };
  };
}
