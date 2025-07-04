{ lib, ... }:
{
  wayland.windowManager.hyprland.settings = {
    windowrule =
      let
        float = title: [
          "center, title:^(${title})(.*)$"
          "float, title:^(${title})(.*)$"
        ];

        floatc = class: [
          "center, class:^(${class})(.*)$"
          "float, class:^(${class})(.*)$"
        ];

        # floatcs =
        #   class: xp: yp:
        #   (
        #     [
        #       "size ${xp}% ${yp}%, class:^(${class})(.*)$"
        #     ]
        #     ++ (floatc class)
        #   );
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
        (floatc "org\\.gnome\\.FileRoller")
        (floatc "file-roller")
        (floatc "system-config-printer")
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
