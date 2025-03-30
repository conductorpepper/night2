{
  wayland.windowManager.river.enable = true;
  wayland.windowManager.river.settings = {
    map = {
      normal = {
        "Super Return" = "spawn ghostty";
      };
    };

    spawn = ["rivertile"];
    output-layout = "rivertile";
  };

  wayland.windowManager.river.systemd.enable = false; # conflicts with uwsm
}
