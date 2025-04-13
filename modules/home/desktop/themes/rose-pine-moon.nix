{pkgs, ...}: {
  home.pointerCursor = {
    package = pkgs.rose-pine-hyprcursor;
    name = "rose-pine-hyprcursor"; # only dark for now
  };

  xdg.enable = true;
  xdg.configFile."fcitx5/conf/classicui.conf" = {
    text = ''
      Theme=rose-pine-moon
    '';
  };

  gtk = {
    enable = true;

    theme = {
      name = "rose-pine-moon";
      package = pkgs.rose-pine-gtk-theme;
    };

    iconTheme = {
      name = "rose-pine-moon";
      package = pkgs.rose-pine-icon-theme;
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
        light = "Rosé Pine Dawn";
        dark = "Rosé Pine Moon";
      };

      icon_theme = "Charmed Icons";

      ui_font_size = 12;
      buffer_font_size = 12;
    };
  };

  programs.ghostty.settings = {
    theme = "rose-pine-moon";
    font-family = "JetBrainsMono Nerd Font";
    window-padding-x = 10;
    window-padding-y = 10;
  };

  programs.helix.settings = {
    theme = "rose_pine_moon";
  };

  xdg.configFile."starship.toml" = {
    source = pkgs.fetchurl {
      url = "https://raw.githubusercontent.com/rose-pine/starship/e0356ebb87cf340bfa20c47ff6988b8fe7d24118/rose-pine-moon.toml";
      hash = "sha256-RVHiJ/lFcjecf20yMGFZulRLMnrH9qxIHQ/YaGD5nVo=";
    };
  };
}
