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
        "$mod, Q, exec, xdg-terminal-exec $SHELL" # terminal
        "$mod, S, exec, xdg-open \"about:newtab\"" # browser
        "$mod, A, exec, xdg-open $HOME" # files
        "$mod, W, exec, nwg-drawer" # launcher

        # utils
        "$mod, V, exec, cliphist list | wofi --dmenu | cliphist decode | wl-copy"
        "$mod SHIFT, SPACE, execr, fcitx5-remote -t"
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
  };

  programs.wofi = {
    enable = true;
  };

  home.packages = with pkgs; [
    wl-clipboard
    nwg-drawer
    inputs.hyprpanel.packages.default
  ];
}
