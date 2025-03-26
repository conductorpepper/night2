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
      inputs.impermanence.nixosModules.impermanence
    ];

    # two-space indent my beloved
    # https://github.com/nix-community/disko/blob/master/example/luks-btrfs-subvolumes.nix
    # https://github.com/chewblacka/nixos/tree/main
    # https://github.com/vimjoyer/impermanent-setup/tree/main
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
              name = "root";
              size = "100%";
              content = {
                type = "lvm_pv";
                vg = "root_vg";
              };
            };
          };
        };
      };

      lvm_vg = {
        root_vg = {
          type = "lvm_vg";
          lvs = {
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
                    "@home" = {
                      mountpoint = "/home";
                      inherit mountOptions;
                    };
                    "@nix" = {
                      mountpoint = "/nix";
                      inherit mountOptions;
                    };
                    "@cache" = {
                      mountpoint = "/var/cache";
                      inherit mountOptions;
                    };
                    "@log" = {
                      mountpoint = "/var/log";
                      inherit mountOptions;
                    };
                    "@tmp" = {
                      mountpoint = "/var/tmp";
                      inherit mountOptions;
                    };
                    "@persist" = {
                      mountpoint = "/persist";
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

    fileSystems."/persist".neededForBoot = true;
    fileSystems."/var/log".neededForBoot = true;
    fileSystems."/var/tmp".neededForBoot = true;

    environment.persistence = {};
  };
}
