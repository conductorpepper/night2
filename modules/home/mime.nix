{
  xdg.mime.enable = true;
  xdg.mimeApps.enable = true;

  # maybe i'll just persist this...
  # `xdg-mime query filetype <file>` to get mimetypes
  # TODO: make a little tree, add vscodium, set pdf
  xdg.mimeApps.defaultApplications =
    let
      application = name: "application/${name}";
      image = name: "image/${name}";
      text = name: "text/${name}";
      video = name: "video/${name}";
      x-scheme-handler = name: "x-scheme-handler/${name}";
      list = builtins.map (x: x + ".desktop");
    in
    {
      # application
      ${application "x-desktop"} = list [
        "Helix"
        "writer"
      ];
      ${application "x-krita"} = list [ "krita_kra" ];
      ${application "x-zerosize"} = list [
        "Helix"
        "writer"
      ];
      ${application "xml"} = list [
        "Helix"
        "writer"
      ];
      ${application "zip"} = list [ "org.gnome.FileRoller" ];
      ${application "edje"} = list [
        "Helix"
      ];
      ${application "json"} = list [
        "Helix"
      ];
      ${application "octet-stream"} = list [ "Helix" ];
      ${application "x-godot-resource"} = list [ "Helix" ];
      ${application "x-extension-htm"} = list [ "zen" ];
      ${application "x-extension-html"} = list [ "zen" ];
      ${application "x-extension-shtml"} = list [ "zen" ];
      ${application "x-xhtml+xml"} = list [ "zen" ];
      ${application "x-extension-xhtml"} = list [ "zen" ];
      ${application "x-extension-xht"} = list [ "zen" ];
      ${application "x-extension-x-wine-extension-ini"} = list [
        "Helix"
      ];
      ${application "pdf"} = list [
        "okular"
        "qpdfview"
        "mupdf"
      ];

      # image
      ${image "gif"} = list [
        "krita_gif"
        "zen"
      ];
      ${image "jpeg"} = list [
        "feh"
        "krita_jpeg"
        "zen"
        "draw"
      ];
      ${image "jpg"} = list [
        "feh"
        "krita_jpg"
        "zen"
        "draw"
      ];
      ${image "png"} = list [
        "feh"
        "krita_png"
        "zen"
        "draw"
      ];
      ${image "svg+xml"} = list [
        "feh"
        "krita_svg"
        "zen"
        "draw"
      ];

      # text
      ${text "html"} = list [ "zen" ];
      ${text "plain"} = list [
        "Helix"
        "writer"
      ];
      ${text "markdown"} = list [
        "Helix"
      ];

      # video
      ${video "mp4"} = list [
        "mpv"
        "vlc"
      ];
      ${video "x-matroska"} = list [
        "mpv"
        "vlc"
      ];

      # x-scheme-handler
      ${x-scheme-handler "discord"} = list [ "vesktop" ]; # may not actually work
      ${x-scheme-handler "http"} = list [ "zen" ];
      ${x-scheme-handler "https"} = list [ "zen" ];
      ${x-scheme-handler "chrome"} = list [ "zen" ];
      ${x-scheme-handler "ror2mm"} = list [ ".gale-wrapped-handler" ];
      ${x-scheme-handler "roblox-studio-auth"} = list [ "org.vinegarhq.Vinegar.studio" ];
      ${x-scheme-handler "roblox-player"} = list [ "org.vinegarhq.Sober" ];

      # misc
      "inode/directory" = list [
        "nemo"
        "thunar"
        "org.gnome.Nautilus"
        "ranger"
      ];
      "inode/mount-point" = list [
        "nemo"
        "thunar"
        "org.gnome.Nautilus"
        "ranger"
      ];
      "ror2mm" = list [ ".gale-wrapped-handler" ];
    };
}
