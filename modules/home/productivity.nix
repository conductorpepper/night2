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

      # https://addons.mozilla.org/api/v5/addons/addon/NAME/
      ExtensionSettings =
        let
          extension = name: guid: {
            inherit name;
            value = {
              installation_mode = "force_installed";
              install_url = "https://addons.mozilla.org/firefox/downloads/latest/${name}/latest.xpi";
            };
          };
        in
        builtins.listToAttrs [
          (extension "ublock-origin" "uBlock0@raymondhill.net")
          (extension "keepassxc-browser" "keepassxc-browser@keepassxc.org")
          (extension "indie-wiki-buddy" "{cb31ec5d-c49a-4e5a-b240-16c767444f62}")
          (extension "vimium-ff" "{d7742d87-e61d-4b78-b8a1-b469842139fa}")
          (extension "yomitan" "{6b733b82-9261-47ee-a595-2dda294a4d08}")
          (extension "sponsorblock" "sponsorBlocker@ajay.app")
          (extension "return-youtube-dislikes" "{762f9885-5a13-4abd-9c77-433dcd38b8fd}")
          (extension "plasma-integration" "plasma-browser-integration@kde.org")
        ];
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
