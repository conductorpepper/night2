{ pkgs, ... }:
{
  xdg.enable = true;
  gtk.enable = true;

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
