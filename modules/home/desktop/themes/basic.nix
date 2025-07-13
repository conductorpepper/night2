{ pkgs, ... }:
{
  home.pointerCursor = {
    name = "breeze_cursors";
    package = pkgs.kdePackages.breeze-gtk;
  };

  xdg.enable = true;

  gtk = {
    enable = true;
    theme = {
      name = "Breeze-Dark";
      package = pkgs.kdePackages.breeze-gtk;
    };

    iconTheme = {
      name = "Breeze Dark";
      package = pkgs.kdePackages.breeze-icons;
    };

    font = {
      name = "Inter";
      package = pkgs.inter;
    };
  };

  programs.zed-editor = {
    extensions = [
      # themes
      "charmed-icons"
    ];

    userSettings = {
      theme = {
        mode = "system";
      };

      icon_theme = "Base Charmed Icons";

      ui_font_size = 16;
      buffer_font_size = 16;
    };
  };

  programs.ghostty.settings = {
    font-family = "JetBrainsMono Nerd Font";
    window-padding-x = 10;
    window-padding-y = 10;
  };
}
