{
  config,
  flake,
  pkgs,
  lib,
  ...
}: let
  inherit (flake) inputs;
in {
  programs.git = let
    user = flake.config.utils.user;
  in {
    enable = true;
    userEmail = user.email;
    userName = user.username;
    fullName = user.fullname;
  };

  programs.gh = {
    enable = true;
    gitCredentialHelper.enable = true;
  };

  programs.bash.enable = true;
  programs.bash.enableCompletion = true;

  programs.zsh.enable = true;
  programs.zsh.enableCompletion = true;
  programs.zsh.autosuggestion.enable = true;
  programs.zsh.initExtra = ''
    # Starship
    eval "$(starship init zsh)"
  '';

  programs.nushell = {
    enable = true;
    configFile.text = ''
      let carapace_completer = {|spans|
        carapace $spans.0 nushell ...$spans | from json
      }

      # sync with home.sessionPath for some reason
      $env.PATH = ($env.PATH |
        split row (char esep) |
        append "/home/jan/.local/bin"
      )

      $env.config.show_banner = false

      mkdir ($nu.data-dir | path join "vendor/autoload")
      starship init nu | save -f ($nu.data-dir | path join "vendor/autoload/starship.nu")
    '';
  };

  programs.starship.enable = true;
  programs.starship.enableBashIntegration = true;
  programs.starship.enableZshIntegration = true;
  programs.starship.enableNushellIntegration = true;

  programs.carapace = {
    enable = true;
    enableNushellIntegration = true;
  };

  home.shell = {
    enableBashIntegration = true;
    enableZshIntegration = true;
    enableNushellIntegration = true;
  };

  programs.ghostty = {
    enable = true;
  };

  programs.helix.enable = true;

  programs.vscode.enable = true;
  programs.vscode.package = pkgs.vscodium;
  programs.vscode.extensions = with pkgs.vscode-extensions; [
    yzhang.markdown-all-in-one
    rust-lang.rust-analyzer
    dbaeumer.vscode-eslint
    tamasfe.even-better-toml
    ritwickdey.liveserver
    jnoortheen.nix-ide
    esbenp.prettier-vscode
    thenuprojectcontributors.vscode-nushell-lang
    redhat.vscode-xml
    mvllow.rose-pine
    usernamehw.errorlens
    streetsidesoftware.code-spell-checker
    mkhl.direnv
  ];

  programs.zed-editor.enable = true;
  programs.zed-editor = {
    extensions = [
      # languages
      "nix"
      "luau"
      "lua"
      "markdown-oxide"
      "just"
      "kotlin"
      "java"
      "hyprlang"
      "gdscript"
      "superhtml"
      "nu"
      "toml"
      "vtsls"

      # themes
      "charmed-icons"
      "rose-pine-theme"
    ];

    userSettings = {
      features = {
        copilot = false;
      };
      assistant = {
        enabled = false;
      };
      telemetry = {
        metrics = false;
      };

      vim_mode = true;
      load_direnv = "shell_hook";
      base_keymap = "VSCode";
      hour_format = "hour24";
      auto_update = false;

      terminal = {
        dock = "bottom";
        detect_venv = {
          on = {
            directories = [".env" "env" ".venv" "venv"];
            activate_script = "default";
          };
        };
        env.TERM = "ghostty";
        # font_family
        # font_features
        # font_size
        line_height = "comfortable";
        shell.program = "nu";
        toolbar.title = true;
      };

      lsp = {
        rust-analyzer.binary.path_lookup = true;
        nix.binary.path_lookup = true;
        luau-lsp.settings = {
          luau-lsp = {};
          ext = {
            roblox.enabled = false;
          };
          fflags = {
            enable_new_solver = true;
            sync = true;
          };
        };
      };

      languages = {
        Lua = {
          format_on_save = "on";
          formatter.external.command = "stylua";
          syntax = "Lua51";
        };
        Luau = {
          format_on_save = "on";
          formatter.external.command = "stylua";
          syntax = "Luau";
        };
      };

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

  # apparently gio priortizes "xdg_terminal_exec" first,
  # so to set it, we do this
  home.file.".local/bin/xdg-terminal-exec" = {
    executable = true;
    text = ''
      #!${lib.getExe config.programs.nushell.package}

      def main [...args: string] {
        ${lib.getExe config.programs.ghostty.package} -e ...$args
      }
    '';

    # text = ''
    #   #!${lib.getExe config.programs.zsh.package}
    #   ${lib.getExe config.programs.ghostty.package} -e "$@"
    # '';
  };

  home.sessionVariables = {
    EDITOR = "hx";
  };

  home.sessionPath = [
    "$HOME/.local/bin"
  ];

  home.packages = with pkgs; [
    # audio
    bespokesynth
    tenacity

    # game
    trenchbroom
    godot_4

    # modeling
    blender
    blockbench

    # blender hangs on intel integrated graphics
    # so this is a workaround
    # https://askubuntu.com/questions/1477715/blender-hangs-using-intel-integrated-graphics
    (writeShellScriptBin "blender-igp" ''
      echo 10000 | sudo tee /sys/class/drm/card1/engine/rcs0/preempt_timeout_ms
      INTEL_DEBUG=reemit blender
    '')

    # editors
    jetbrains.idea-community-bin

    # language
    rust-analyzer
    stylua
    nil
    inputs.nyxexprs.packages.${pkgs.stdenv.hostPlatform.system}.alejandra-custom
  ];
}
