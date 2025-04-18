{pkgs, ...}: {
  boot = {
    plymouth = {
      enable = true;
      theme = "polaroid";
      themePackages = with pkgs; [
        (adi1090x-plymouth-themes.override {
          selected_themes = ["polaroid"];
        })
      ];
    };

    consoleLogLevel = 3;
    initrd.verbose = false;
    kernelParams = [
      "quiet"
      "splash"
      "boot.shell_on_fail"
      "udev.log_priority=3"
      "rd.systemd.show_status=auto"
    ];

    loader.timeout = 5;
  };
}
