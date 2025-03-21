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
  options.utils.disk = {
    enable = mkEnableOption "automatic disko configuration";
    device = mkOption {
      type = types.str;
    };
  };

  config = mkIf cfg.enable {
    imports = [
      inputs.disko.nixosModules.disko
    ];

    # two-space indent my beloved
    # https://github.com/nix-community/disko/blob/master/example/luks-btrfs-subvolumes.nix
    disko.devices = {
      disk = {
        main = {
          type = "disk";
          device = cfg.device;
          content = {
            type = "gpt";
            partitions = {
              ESP = {
                size = "512M";
                type = "EF00";
                content = {
                  type = "filesystem";
                  format = "vfat";
                  mountpoint = "/boot";
                  mountOptions = ["umask=0077"];
                };
              };
              luks = {
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
                    subvolumes = {
                      "@" = {
                        mountpoint = "/";
                        mountOptions = ["compress=zstd" "noatime"];
                      };
                      "@home" = {
                        mountpoint = "/home";
                        mountOptions = ["compress=zstd" "noatime"];
                      };
                      "@nix" = {
                        mountpoint = "/nix";
                        mountoptions = ["compress=zstd" "noatime"];
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
  };
}
