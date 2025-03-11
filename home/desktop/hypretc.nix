{
  config,
  pkgs,
  ...
}: {
  # lock
  programs.hyprlock.enable = true;

  # idle
  services.hypridle.enable = true;
  services.hypridle.settings = let
    bash = config.programs.bash.package;
    lock = config.programs.hyprlock.package;
    hyprctl = "${config.wayland.windowManager.hyprland.package}/bin/hyprctl";
    inherit (pkgs) procps systemd;
  in {
    general = {
      lock_cmd = ''
        ${bash} -c "${procps}/bin/pidof ${lock} || ${lock}" &
      '';
      before_sleep_cmd = "${systemd}/bin/loginctl lock-session &";
      after_sleep_cmd = "${hyprctl} dispatch dpms on";
    };

    listener =
      [
        {
          timeout = 120;
          on-timeout = "${hyprctl} dispatch dpms off";
          on-resume = "${hyprctl} dispatch dpms on";
        }
      ]
      ++ (
        if config.utils.exssd
        then []
        else [
          {
            timeout = 180;
            on-timeout = "${systemd}/bin/systemctl suspend";
          }
        ]
      );
  };
}
