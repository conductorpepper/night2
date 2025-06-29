{ pkgs, ... }:
{
  home.pointerCursor = {
    package = pkgs.rose-pine-cursor;
    name = "BreezeX-RosePine-Linux";
  };

  xdg.enable = true;
  xdg.configFile."fcitx5/conf/classicui.conf" = {
    text = ''
      Theme=rose-pine
    '';
  };

  gtk = {
    enable = true;

    theme = {
      name = "rose-pine";
      package = pkgs.rose-pine-gtk-theme;
    };

    iconTheme = {
      name = "rose-pine";
      package = pkgs.rose-pine-icon-theme;
    };

    font = {
      name = "Inter";
      package = pkgs.inter;
    };

    # maybe package pier sans at some point
    # (used for the rose pine website (or don't and just use what ui-sans-serif uses))
  };

  programs.zed-editor = {
    extensions = [
      # themes
      "charmed-icons"
      "rose-pine-theme"
    ];

    userSettings = {
      theme = {
        mode = "system";
        light = "Rosé Pine";
        dark = "Rosé Pine";
      };

      icon_theme = "Soft Charmed Icons";

      ui_font_size = 16;
      buffer_font_size = 16;
    };
  };

  programs.ghostty.settings = {
    theme = "rose-pine";
    font-family = "JetBrainsMono Nerd Font";
    window-padding-x = 10;
    window-padding-y = 10;
  };

  programs.helix.settings = {
    theme = "rose_pine";
  };

  xdg.configFile."starship.toml" = {
    source = pkgs.fetchurl {
      url = "https://raw.githubusercontent.com/rose-pine/starship/ce244cb048e19ef6207936c3087141c8a796bca5/rose-pine.toml";
      hash = "sha256-0nK3gRQDuoH+jAvKWbM04rVUXtFNRgvB86jKhuvnr9g=";
    };
  };

  wayland.windowManager.hyprland.settings = {
    general = {
      border_size = 0;
    };

    decoration = {
      rounding = 8;
    };

    bezier = [
      "easeOutExpo, 0.19, 1, 0.22, 1"
    ];

    animation = [
      # windows
      "windowsIn, 1, 6, easeOutExpo, popin 80%"
      "windowsOut, 1, 2, easeOutExpo, popin 80%"
      "windowsMove, 1, 2, easeOutExpo, slide"

      # layers
      "layersIn, 1, 6, easeOutExpo, popin 80%"
      "layersOut, 1, 2, easeOutExpo, popin 80%"

      # workspaces
      "workspaces, 1, 6, easeOutExpo, slidefadevert 80%"
    ];
  };

  # stack overflow; max-call-depth exceeded
  # wayland.windowManager.hyprland.settings.source = [
  #   (pkgs.fetchurl {
  #     url = "https://raw.githubusercontent.com/rose-pine/hyprland/6898fe967c59f9bec614a9a58993e0cb8090d052/rose-pine-dawn.conf";
  #     hash = "sha256-5/j0eTKTPU67nmMjK3M8BrGvmYtoRI14bgBfbdBpbps=";
  #   })
  # ];

  home.packages = with pkgs; [
    fcitx5-rose-pine
  ];
}
