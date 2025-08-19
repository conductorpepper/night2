{
  config,
  pkgs,
  ...
}:
{

  programs.obs-studio = {
    enable = true;
    plugins = with pkgs.obs-studio-plugins; [
      wlrobs
      obs-pipewire-audio-capture
      obs-vkcapture
    ];
  };

  programs.anki = {
    enable = true;
    addons = with pkgs.ankiAddons; [
      anki-connect
    ];
    sync = {
      autoSync = true;
      autoSyncMediaMinutes = 15;
      networkTimeout = 60;
      syncMedia = true;
      usernameFile = config.sops.secrets."anki/email".path;
      passwordFile = config.sops.secrets."anki/sync".path;
    };
  };

  home.sessionVariables = {
    # wayland
    NIXOS_OZONE_WL = "1";
    MOZ_ENABLE_WAYLAND = "1";
  };

  home.packages = with pkgs; [
    # audio
    easyeffects

    # browser
    wike
    kiwix

    # wine
    wineWowPackages.waylandFull

    # files
    ranger
    unzip
    veracrypt
    deja-dup

    # image
    krita
    curtail
    tuxpaint
    aseprite
    glaxnimate
    gimp3-with-plugins
    kdePackages.kolourpaint

    # writing
    libreoffice-qt
    obsidian
    logseq
    zathura
    hunspell
    hunspellDicts.en_US
    pdftk
    kdePackages.kcharselect

    # mail
    thunderbird

    # pass
    keepassxc

    # video
    vlc
    mpv
    kdePackages.kdenlive
    yt-dlp

    # learning
    # anki-bin

    # reading
    kdePackages.okular

    # computer
    btop
    kdePackages.ksystemlog
    kdePackages.filelight

    # meetings
    zoom-us

    # printers & scanners
    kdePackages.skanlite
    kdePackages.skanpage

    # math
    kdePackages.kcalc

    # desktop things
    app2unit
    trash-cli
  ];
}
