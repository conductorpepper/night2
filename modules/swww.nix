# swww is a home-manager module
# this is VERY not the swww way btw :3
{
  config,
  pkgs,
  lib,
  ...
}: let
  cfg = config.services.swww;
  inherit (lib) mkOption types literalExpression getExe;

  imageSettings = types.submodule {
    options = {
      image = mkOption {
        type = types.path;
        example = literalExpression "./wallpaper.png";
        description = ''
          Image to set for the selected outputs
        '';
      };

      outputs = mkOption {
        type = types.listOf types.str;
        example = literalExpression "[ \"HDMI-A-1\" \"DP-3\" ]";
        default = [];
        defaultText = literalExpression "[]";
        description = ''
          List of outputs to display the image at.
          If it isn't set, the image is displayed on all outputs.
          Leave empty to set the image to all outputs.
        '';
      };

      resize = mkOption {
        type = types.enum ["no" "crop" "fit"];
        example = "no";
        default = "crop";
        defaultText = "crop";
        description = "Whether to resize the image and the method by which to resize it";
      };

      fillColor = mkOption {
        type = types.str;
        example = "FFFFFF";
        default = "000000";
        defaultText = "000000";
        description = "Which color to fill the padding with when output image does not fill screen";
      };

      filter = mkOption {
        type = types.enum [
          "Nearest"
          "Bilinear"
          "CatmullRom"
          "Mitchell"
          "Lanczos3"
        ];
        example = "Nearest";
        default = "Lanczos3";
        defaultText = "Lanczos3";
        description = "Filter to use when scaling images";
      };

      # i don't really like this option
      extraOptions = mkOption {
        type = types.listOf types.str;
        example = literalExpression ''
          [
              "--transition-fps 30"
              "--transition-angle 45"
              "--invert-y"
          ]
        '';
        default = [];
        defaultText = literalExpression "[]";
        description = "Extra options to give to the command";
      };
    };
  };
in {
  options.services.swww = {
    enable = lib.mkEnableOption "swww";
    package = mkOption {
      type = types.package;
      default = pkgs.swww;
      defaultText = literalExpression "pkgs.swww";
      description = "swww package to use";
    };

    images = mkOption {
      type = types.listOf imageSettings;
      default = "[]";
      defaultText = literalExpression "[]";
      description = "list of image settings";
    };

    format = mkOption {
      type = types.enum [
        "xrgb"
        "xbgr"
        "rgb"
        "bgr"
      ];
      default = "xrgb";
      description = ''
        force the use of a specific wl_shm format.

        only use this as a workaround when you run into problems, and
        make sure the compositor actually supports it.
      '';
    };

    no-cache = mkOption {
      type = types.bool;
      default = false;
      description = "don't search the cache for the last wallpaper for each output.";
    };

    systemdTarget = mkOption {
      type = types.str;
      default = "graphical-session.target";
    };
  };

  config = lib.mkIf cfg.enable {
    systemd.user.services.swww = {
      Unit = {
        Description = "Efficient animated wallpaper daemon for wayland, controlled at runtime";
        PartOf = ["graphical-session.target"];
      };

      Service = {
        ExecStart = let
          daemon = "${cfg.package}/bin/swww-daemon";
        in "${daemon} --format ${cfg.format} ${
          if cfg.no-cache
          then "--no-cache"
          else ""
        }";
        ExecStop = let
          swww = lib.getExe cfg.package;
        in "${swww} kill";
        ExecReload = let
          swww = getExe cfg.package;

          uniteOutputs = list: (builtins.concatStringsSep "," list);
          getOutputsCommand = list: let
            length = builtins.length list;
            isEmpty = length == 0;
          in
            if isEmpty
            then ""
            else "--outputs ${uniteOutputs list}";

          createCommand = imgs: "${swww} img ${getOutputsCommand imgs.outputs} --resize ${imgs.resize} --fill-color ${imgs.fillColor} --filter ${imgs.filter} ${builtins.concatStringsSep " " imgs.extraOptions} ${imgs.image}";
        in "${getExe pkgs.bash} -c \"${builtins.concatStringsSep " && " (builtins.map (x: createCommand x) cfg.images)}\"";
        Restart = "no";
      };

      Install.WantedBy = [cfg.systemdTarget];
    };
  };
}
