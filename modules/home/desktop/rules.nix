{
  wayland.windowManager.hyprland.settings = {
    windowrule = [
      "center, title:^(Open File)(.*)$"
      "float, title:^(Open File)(.*)$"

      "center, title:^(Select a File)(.*)$"
      "float, title:^(Select a File)(.*)$"

      "center, title:^(Choose wallpaper)(.*)$"
      "float, title:^(Choose wallpaper)(.*)$"

      "center, title:^(Open Folder)(.*)$"
      "float, title:^(Open Folder)(.*)$"

      "center, title:^(Save As)(.*)$"
      "float, title:^(Save As)(.*)$"

      "center, title:^(Save File)(.*)$"
      "float, title:^(Save File)(.*)$"

      "center, title:^(Library)(.*)$"
      "float, title:^(Library)(.*)$"

      "center, title:^(File Upload)(.*)$"
      "float, title:^(File Upload)(.*)$"

      "center, title:^(Authentication Required)(.*)$"
      "float, title:^(Authentication Required)(.*)$"
    ];

    windowrulev2 = [
      # gnome calculator
      "float, class:^(org.gnome.Calculator)$"
      "pin, class:^(org.gnome.Calculator)$"
      "size 415 621, class:^(org.gnome.Calculator)$"

      # PiP
      "float, title:^(Picture-in-Picture)$"
      "pin, title:^(Picture-in-Picture)$"
    ];
  };
}
