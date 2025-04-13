{lib, ...}: {
  wayland.windowManager.hyprland.settings = {
    windowrule = let
      float = dialog: [
        "center, title:^(${float})(.*)$"
        "float, title:^(${float})(.*)$"
      ];
    in
      lib.lists.flatten [
        (float "Open File")
        (float "Select a File")
        (float "Choose wallpaper")
        (float "Open Folder")
        (float "Save As")
        (float "Save File")
        (float "Library")
        (float "File Upload")
        (float "Authentication Required")
        (float "Select Folders")
      ];

    windowrulev2 = [
      # gnome calculator
      "float, class:^(org.gnome.Calculator)$"
      "pin, class:^(org.gnome.Calculator)$"
      "size 415 621, class:^(org.gnome.Calculator)$"

      # PiP
      "float, title:^(Picture-in-Picture)$"
      "pin, title:^(Picture-in-Picture)$"

      # hyprbars
      "plugin:hyprbars:nobar, floating:0"
    ];
  };
}
