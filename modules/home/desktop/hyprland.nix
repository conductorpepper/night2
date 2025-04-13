{
  flake,
  pkgs,
  ...
}: let
  inherit (flake) inputs;
in {
  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = false; # conflicts with uwsm
  };

  wayland.windowManager.hyprland.settings = {
    general = {
      resize_on_border = true;
      layout = "master";
      snap = {
        enabled = true;
      };
    };

    "$mod" = "SUPER";
    bind =
      [
        # hyprland
        "$mod, X, killactive"
        "$mod, M, exec, hyprctl dispatch exit"
        "$mod, L, exec, loginctl lock-session"

        "$mod, F, fullscreen, 0"
        "$mod, SPACE, togglefloating"

        "$mod, right, movefocus, r"
        "$mod, left, movefocus, l"
        "$mod, down, movefocus, d"
        "$mod, up, movefocus, u"

        "$mod CTRL, right, movewindow, r"
        "$mod CTRL, left, movewindow, l"
        "$mod CTRL, down, movewindow, d"
        "$mod CTRL, up, movewindow, u"

        "$mod SHIFT, right, resizeactive, 100 0"
        "$mod SHIFT, left, resizeactive, -100 0"
        "$mod SHIFT, down, resizeactive, 0 100"
        "$mod SHIFT, up, resizeactive, 0 -100"

        # programs
        "$mod, Q, exec, ghostty" # terminal
        "$mod, S, exec, zen" # browser
        "$mod, A, exec, xdg-open $HOME" # files
        "$mod, W, exec, nwg-drawer" # launcher

        # utils
        "$mod, V, exec, cliphist list | wofi --dmenu | cliphist decode | wl-copy"
        "$mod SHIFT, SPACE, execr, fcitx5-remote -t"

        # plugins
        "$mod, D, exec, hyprctl dispatch overview:toggle" # this is not ergonomic.
      ]
      ++ (
        # workspaces
        # binds $mod + [shift +] {1..10} to [move to] workspace {1..10}
        builtins.concatLists (
          builtins.genList (
            x: let
              ws = let
                c = (x + 1) / 10;
              in
                builtins.toString (x + 1 - (c * 10));
            in [
              "$mod, ${ws}, workspace, ${toString (x + 1)}"
              "$mod CTRL, ${ws}, movetoworkspace, ${toString (x + 1)}"
            ]
          )
          10
        )
      );

    bindm = [
      "$mod, mouse:272, movewindow"
      "$mod, mouse:273, resizewindow"
    ];

    exec-once = [
      "lxqt-policykit-agent"

      "hyprpanel"

      "cliphist wipe"
      "wl-paste --type text --watch cliphist store"
      "wl-paste --type image --watch cliphist store"

      "fcitx5-remote -r"
      "fcitx5 -d --replace &"
      "fcitx5-remote -r"
    ];

    misc = {
      disable_hyprland_logo = true;
    };

    plugin = {
      hyprspace = {};

      # config from https://github.com/pyt0xic/hyprfocus
      hyprfocus = {
        focus_animation = "shrink";
        bezier = [
          "bezIn, 0.5, 0.0, 1.0, 0.5"
          "bezOut, 0.0, 0.5, 0.5, 1.0"
          "overshot, 0.05, 0.9, 0.1, 1.05"
          "smoothOut, 0.36, 0, 0.66, -0.56"
          "smoothIn, 0.25, 1, 0.5, 1"
          "realsmooth, 0.28, 0.29, 0.69, 1.08"
        ];
        shrink = {
          shrink_percentage = 0.95;
          in_bezier = "realsmooth";
          in_speed = 1;
          out_bezier = "realsmooth";
          out_speed = 2;
        };
      };

      hyprbars = {
        bar_height = 32;
        bar_text_size = 24;
        hyprbars-button = [
          "rgb(ff4040), 15, 󰖭, hyprctl dispatch killactive"
          "rgb(eeee11), 15, , hyprctl dispatch fullscreen 1"
        ];
      };

      dynamic-cursors = {
        shake.enabled = false;
      };
    };
  };

  wayland.windowManager.hyprland.plugins = with pkgs.hyprlandPlugins; [
    hyprspace # workspace overview
    # hyprfocus # focus animation (currently broken)
    hyprbars # window title
    hypr-dynamic-cursors # dynamic cursors
  ];

  home.packages = with pkgs; [
    wl-clipboard
    nwg-drawer
    inputs.hyprpanel.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];
}
