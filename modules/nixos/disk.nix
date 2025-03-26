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
    enable = mkEnableOption "automatic disko + impermanence configuration";
    longDescription = ''
      Sets up my preferred Disko and Impermanence configuration.

      Disko is used for delcarative disk management,
      and Impermanence is used to clean up my system.
    '';
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
                        mountOptions = ["compress=zstd" "noatime"];
                      };
                      "@cache" = {
                        mountpoint = "/var/cache";
                        mountOptions = ["compress=zstd" "noatime"];
                      };
                      "@log" = {
                        mountpoint = "/var/log";
                        mountOptions = ["compress=zstd" "noatime"];
                      };
                      "@tmp" = {
                        mountpoint = "/var/tmp";
                        mountOptions = ["compress=zstd" "noatime"];
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

    fileSystems."@persist".neededForBoot = true;
    fileSystems."@log".neededForBoot = true;
  };
}
