{
  flake,
  pkgs,
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
      hiding = "dodgewindows"; # try to avoid burn in on the second monitor
      widgets = [
        "org.kde.plasma.kickoff"
        "org.kde.plasma.pager"
        {
          name = "org.kde.plasma.icontasks";
          config.General.launchers =
            let
              preferred = name: "preferred://${name}";
              app = name: "applications:${name}.desktop";
              # kdeapp = name: (app "org.kde.${name}");
            in
            [
              (app "systemsettings")
              (preferred "filemanager")
              (preferred "browser")
              (app "thunderbird")
              (app "vesktop")
              (app "dev.zed.Zed")
            ];
        }
        "org.kde.plasma.marginsseparator"
        "org.kde.plasma.systemtray"
        "org.kde.plasma.digitalclock"
        "org.kde.plasma.showdesktop"
      ];
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
      "Anime" = {
        command = "ani-cli";
      };
      "Anime Dub" = {
        command = "ani-cli --dub";
      };
      "Internet" = {
        command = "ping www.google.com";
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

  xdg.configFile."starship.toml".source = pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/starship/starship/refs/tags/v1.23.0/docs/public/presets/toml/pastel-powerline.toml";
    hash = "sha256-9ljlFPr9IkQ1Ri1Y29EMj4qMHeW1FV3ltq7spenC+mc=";
  };

  # misc packages
  home.packages = with pkgs.kdePackages; [
    yakuake
  ];
}
