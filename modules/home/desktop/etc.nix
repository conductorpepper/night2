{
  lib,
  pkgs,
  passthru,
  ...
}: {
  # lock
  # some parts are from https://gist.github.com/ashish-kus/dd562b0bf5e8488a09e0b9c289f4574c
  programs.hyprlock.enable = true;
  programs.hyprlock.settings = {
    general = {
      disable_loading_bar = true;
      grace = 5;
      hide_cursor = true;
    };

    auth = {
      fingerprint.enabled = true;
    };

    background = [
      {
        monitor = "";
        path = "screenshot";
        blur_passes = 3;
        blur_size = 8;
        contrast = 0.9;
        brightness = 0.7;
        vibrancy = 0.2;
        vibrancy_darkness = 0;
        noise = 0.04;
      }
    ];

    input-field = {
      monitor = "";
      size = "250, 60";
      outline_thickness = 0;
      position = "0, -470";
      rounding = 0;
    };
  };

  # idle
  services.hypridle.enable = true;
  services.hypridle.settings = let
    toggleOutputs = state: "${lib.getExe pkgs.nushell} ${./etc.nu} toggle-outputs-hypr ${
      if state
      then "true"
      else "false"
    }";
  in {
    general = {
      lock_cmd = ''
        ${lib.getExe pkgs.bash} -c "pidof hyprlock || hyprlock &"
      '';
      before_sleep_cmd = "${pkgs.systemd}/bin/loginctl lock-session &";
      after_sleep_cmd = toggleOutputs true;
    };

    listener =
      [
        {
          timeout = 120;
          on-timeout = toggleOutputs false;
          on-resume = toggleOutputs true;
        }
      ]
      ++ (
        if (passthru.exssd == true)
        then []
        else [
          {
            timeout = 180;
            on-timeout = "${pkgs.systemd}/bin/systemctl suspend";
          }
        ]
      );
  };

  programs.wofi = {
    enable = true;
  };

  # utils
  home.packages = with pkgs; [
    # wlr-randr
    procps
  ];
}
