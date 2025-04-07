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
    inputs.impermanence.nixosModules.impermanence
  ];

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
                    "@persistent" = {
                      mountpoint = "/persistent";
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

    environment.persistence."/persistent" = {
      enable = true;
      hideMounts = true;
      directories = [
        "/var/lib/blueman"
        "/var/lib/cups"
        "/var/lib/nixos"
        "/var/lib/systemd/coredump"
        "/etc/NetworkManager/system-connections"
        "/etc/passwd"
        "/etc/shadow"
        "/etc/night2"
        {
          directory = "/var/lib/colord";
          user = "colord";
          group = "colord";
          mode = "u=rwx,g=rx,o=";
        }
      ];
      files = [
        "/etc/machine-id"
      ];
    };

    environment.persistence."/home" = {
      enable = true;
      hideMounts = true;
    };

    fileSystems."/persistent".neededForBoot = true;
    fileSystems."/home".neededForBoot = true;

    boot.initrd.postDeviceCommands = lib.mkAfter ''
      mkdir -p /btrfs
      mount -o subvol="@" ${cfg.device} /btrfs

      if [[ -e /btrfs/root ]]; then
        mkdir -p /btrfs/old
        timestamp=$(date --date = "@$(stat -c %Y /btrfs/root)" "+%Y-%m-%-d_%H:%M:%S")
        mv /btrfs/root "/btrfs/old/$timestamp"
      fi

      delete_subvolume_recursively() {
        IFS=$'\n'
        for i in (btrfs subvolume list -o "$1" | cut -f 9- -d ' '); do
          delete_subvolume_recursively "/btrfs/$i"
        done
        btrfs subvolume delete "$1"
      }

      for i in $(find /btrfs/old/ -maxdepth 1 -mtime +30); do
        delete_subvolume_recursively "$i"
      done

      btrfs subvolume create /btrfs/root
      umount /btrfs
    '';

    programs.fuse.userAllowOther = true;
  };
}
