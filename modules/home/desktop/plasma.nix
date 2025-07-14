{
  flake,
  lib,
  config,
  passthru,
  ...
}:
{
  imports = [
    flake.inputs.plasma-manager.homeManagerModules.plasma-manager
  ];

  programs.plasma.enable = true;
  programs.plasma.workspace.colorScheme = "BreezeDark";
  programs.plasma.workspace.theme = "breeze-dark";
  programs.plasma.workspace.lookAndFeel = "org.kde.breezedark.desktop";
  programs.plasma.workspace.cursor = {
    size = 24;
    theme = "Breeze Dark";
  };

  programs.plasma.panels = [
    {
      screen = "all";
    }
  ];

  programs.plasma.powerdevil = {
    AC = {
      autoSuspend =
        if passthru.exssd == true then
          {
            action = "nothing";
          }
        else
          {
            action = "sleep";
            idleTimeout = 900;
          };
    };
  };

  programs.plasma.kwin = {
    nightLight = {
      enable = true;
      mode = "times";
      time = {
        morning = "04:00";
        evening = "17:00";
      };
    };

    effects = {
      wobblyWindows.enable = true;
    };
  };

  programs.konsole = {
    enable = true;
    defaultProfile = "Nushell";
    profiles = {
      "Nushell" = {
        command = lib.getExe config.programs.nushell.package;
      };
      "Zsh" = {
        command = lib.getExe config.programs.zsh.package;
      };
      "Anime" = {
        command = "ani-cli";
      };
    };
  };

  # not particularly plasma stuff
  xdg.enable = true;
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
