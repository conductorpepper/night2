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
      audio = name: "audio/${name}";
      x-scheme-handler = name: "x-scheme-handler/${name}";
      list = builtins.map (x: x + ".desktop");
    in
    {
      # application
      ${application "x-desktop"} = list [
        "org.kde.kate"
        "writer"
      ];
      ${application "x-krita"} = list [ "krita_kra" ];
      ${application "x-zerosize"} = list [
        "org.kde.kate"
        "writer"
      ];
      ${application "xml"} = list [
        "org.kde.kate"
        "writer"
      ];
      ${application "zip"} = list [ "org.kde.ark" ];
      ${application "edje"} = list [
        "org.kde.kate"
      ];
      ${application "json"} = list [
        "org.kde.kate"
      ];
      ${application "octet-stream"} = list [ "org.kde.kate" ];
      ${application "x-godot-resource"} = list [ "org.kde.kate" ];
      ${application "x-extension-htm"} = list [ "zen" ];
      ${application "x-extension-html"} = list [ "zen" ];
      ${application "x-extension-shtml"} = list [ "zen" ];
      ${application "x-xhtml+xml"} = list [ "zen" ];
      ${application "x-extension-xhtml"} = list [ "zen" ];
      ${application "x-extension-xht"} = list [ "zen" ];
      ${application "x-extension-x-wine-extension-ini"} = list [
        "org.kde.kate"
      ];
      ${application "pdf"} = list [
        "org.kde.okular"
        "qpdfview"
        "mupdf"
      ];

      # image
      ${image "gif"} = list [
        "org.kde.gwenview"
        "krita_gif"
        "zen"
      ];
      ${image "jpeg"} = list [
        "org.kde.gwenview"
        "krita_jpeg"
        "zen"
        "draw"
      ];
      ${image "jpg"} = list [
        "org.kde.gwenview"
        "krita_jpg"
        "zen"
        "draw"
      ];
      ${image "png"} = list [
        "org.kde.gwenview"
        "krita_png"
        "zen"
        "draw"
      ];
      ${image "svg+xml"} = list [
        "org.kde.gwenview"
        "krita_svg"
        "zen"
        "draw"
      ];

      # text
      ${text "html"} = list [ "zen" ];
      ${text "plain"} = list [
        "org.kde.kate"
        "writer"
      ];
      ${text "markdown"} = list [
        "org.kde.kate"
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
      ${video "x-msvideo"} = list [
        "mpv"
        "vlc"
      ];
      ${video "mpeg"} = list [
        "mpv"
        "vlc"
      ];
      ${video "ogg"} = list [
        "mpv"
        "vlc"
      ];
      ${video "mp2t"} = list [
        "mpv"
        "vlc"
      ];
      ${video "webm"} = list [
        "mpv"
        "vlc"
      ];
      ${video "3gpp"} = list [
        "mpv"
        "vlc"
      ];
      ${video "3gpp2"} = list [
        "mpv"
        "vlc"
      ];

      # audio
      ${audio "acc"} = list [ "org.kde.elisa" ];
      ${audio "midi"} = list [ "org.kde.elisa" ];
      ${audio "x-midi"} = list [ "org.kde.elisa" ];
      ${audio "mpeg"} = list [ "org.kde.elisa" ];
      ${audio "ogg"} = list [ "org.kde.elisa" ];
      ${audio "wav"} = list [ "org.kde.elisa" ];
      ${audio "webm"} = list [ "org.kde.elisa" ];
      ${audio "3gp"} = list [ "org.kde.elisa" ];
      ${audio "3gpp2"} = list [ "org.kde.elisa" ];

      # x-scheme-handler
      ${x-scheme-handler "discord"} = list [ "vesktop" ]; # may not actually work
      ${x-scheme-handler "http"} = list [ "zen" ];
      ${x-scheme-handler "https"} = list [ "zen" ];
      ${x-scheme-handler "chrome"} = list [ "zen" ];
      ${x-scheme-handler "ror2mm"} = list [ ".gale-wrapped-handler" ];
      ${x-scheme-handler "roblox-studio-auth"} = list [ "org.vinegarhq.Vinegar.studio" ];
      ${x-scheme-handler "roblox-player"} = list [ "org.vinegarhq.Sober" ];
      ${x-scheme-handler "mailto"} = list [
        "thunderbird"
        "deltachat"
      ];

      # misc
      "inode/directory" = list [
        "org.kde.dolphin"
        "ranger"
      ];
      "inode/mount-point" = list [
        "org.kde.dolphin"
        "ranger"
      ];
      "ror2mm" = list [ ".gale-wrapped-handler" ];
    };
}
