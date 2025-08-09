{
  flake,
  config,
  pkgs,
  ...
}:
let
  inherit (flake) inputs;
in
{
  imports = [
    inputs.zen-browser.homeModules.twilight
  ];

  programs.zen-browser = {
    enable = true;
    nativeMessagingHosts = with pkgs; [
      kdePackages.plasma-browser-integration
    ];
    policies = {
      EnableTrackingProtection = {
        Value = true;
        Locked = true;
        Cryptomining = true;
        Fingerprinting = true;
        Category = "strict";
      };

      Preferences = { };

      ExtensionSettings = {
        "uBlock0@raymondhill.net" = {
          installation_mode = "force_installed";
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi";
        };
        "keepassxc-browser@keepassxc.org" = {
          installation_mode = "force_installed";
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/keepassxc-browser/latest.xpi";
        };
        "{cb31ec5d-c49a-4e5a-b240-16c767444f62}" = {
          # indie wiki buddy
          installation_mode = "force_installed";
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/indie-wiki-buddy/latest.xpi";
        };
        # TODO: sponsorblock, vimium, yomitan, return youtube dislikes, plasma integration
      };
    }
    // (builtins.listToAttrs (
      builtins.map
        (name: {
          inherit name;
          value = true;
        })
        [
          # all policies to enable
          "DisableAppUpdate"
          "DisableFeedbackCommands"
          "DisableFirefoxStudies"
          "DisablePocket"
          "DisableTelemetry"
          "DontCheckDefaultBrowser"
          "NoDefaultBookmarks"
        ]
    ))
    // (builtins.listToAttrs (
      builtins.map
        (name: {
          inherit name;
          value = false;
        })
        [
          # all policies to disable
          "AutofillAddressEnabled"
          "AutofillCreditCardEnabled"
          "OfferToSaveLogins" # may interfere with keepassxc? idk
        ]
    ));
  };

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
