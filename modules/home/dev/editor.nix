{ pkgs, ... }:
{
  programs.vscode.enable = true;
  programs.vscode.package = pkgs.vscodium;
  programs.vscode.profiles.default.extensions = with pkgs.vscode-extensions; [
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
      "scss"
      "liquid"
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
            directories = [
              ".env"
              "env"
              ".venv"
              "venv"
            ];
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

      file_types = {
        "HTML" = [ "njk" ];
      };

      lsp = {
        rust-analyzer.binary.path_lookup = true;
        nix.binary.path_lookup = true;
        luau-lsp.settings = {
          luau-lsp = { };
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
          syntax = "Lua51";
          formatter.external = {
            command = "stylua";
            arguments = [
              "--syntax=Lua51"
              "--respect-ignores"
              "--stdin-filepath"
              "{buffer_path}"
              "-"
            ];
          };
        };
        Luau = {
          format_on_save = "on";
          syntax = "Luau";
          formatter.external = {
            command = "stylua";
            arguments = [
              "--syntax=Luau"
              "--respect-ignores"
              "--stdin-filepath"
              "{buffer_path}"
              "-"
            ];
          };
        };
        Nix = {
          language_servers = [
            "nixd"
            "!nil"
          ];
          format_on_save = "on";
          formatter = {
            external = {
              command = "nixfmt";
              arguments = [
                "--quiet"
                "--"
              ];
            };
          };
        };
        Liquid = {
          prettier = {
            allowed = true;
            plugins = [
              "@shopify/prettier-plugin-liquid"
            ];
          };
        };
      };
    };
  };

  programs.helix.enable = true;
  programs.neovim.enable = true;

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  home.packages = with pkgs; [
    # editors
    jetbrains.idea-community-bin

    # language
    rust-analyzer
    lua-language-server
    stylua
    nixd
    markdown-oxide
    vtsls
    package-version-server
    luau-lsp
    nixfmt-rfc-style
  ];
}
