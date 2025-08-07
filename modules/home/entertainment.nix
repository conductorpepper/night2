{
  flake,
  pkgs,
  ...
}:
let
  inherit (flake) inputs;
  system = pkgs.stdenv.hostPlatform.system;
in
{
  services.arrpc.enable = true;

  programs.vesktop.enable = true;
  programs.vesktop.settings = {
    discordBranch = "stable";
    minimizeToTray = true;
    arRPC = true;
    splashColor = "rgb(50, 51, 57)";
    splashBackground = "rgb(251, 251, 251)";
    spellCheckLanguages = [
      "en-US"
      "en"
    ];
  };
  programs.vesktop.vencord.settings = {
    autoUpdate = false;
    autoUpdateNotification = false;
    notifyAboutUpdates = false;
    useQuickCss = true;
    themeLinks = [ ];
    eagerPatches = false;
    enabledThemes = [ ];
    enableReactDevtools = false;
    frameless = false;
    transparent = false;
    winCtrlQ = false;
    disableMinSize = false;
    winNativeTitleBar = false;
    plugins = {
      BetterSettings = {
        enabled = true;
        disableFade = true;
        eagerLoad = true;
      };
      CrashHandler = {
        enabled = true;
        attemptToPreventCrashes = true;
        attemptToNavigateToHome = false;
      };
      MentionAvatars = {
        enabled = true;
        showAtSymbol = true;
      };
      MessageLatency = {
        enabled = true;
        latency = 2;
        detectDiscordKotlin = true;
        showMillis = false;
      };
      MessageLinkEmbeds = {
        enabled = true;
        listMode = "blacklist";
        idList = "";
        automodEmbeds = "never";
      };
      # not sure what this actually does
      NewGuildSettings = {
        enabled = true;
        guild = true;
        messages = 3;
        everyone = true;
        role = true;
        highlights = true;
        events = true;
        showAllChannels = true;
      };
      ShikiCodeblocks = {
        enabled = true;
        theme = "https://raw.githubusercontent.com/shikijs/textmate-grammars-themes/2d87559c7601a928b9f7e0f0dda243d2fb6d4499/packages/tm-themes/themes/dark-plus.json";
        tryHIjs = "SECONDARY";
        useDevIcon = "GREYSCALE";
        bgOpacity = 100;
      };
      Settings = {
        enabled = true;
        settingsLocation = "aboveNitro";
      };
      GameActivityToggle = {
        enabled = true;
        oldIcon = false;
      };
    }
    // (builtins.listToAttrs (
      builtins.map
        (name: {
          inherit name;
          value = {
            enabled = true;
          };
        })
        [
          "CommandsAPI"
          "MessageAccessoriesAPI"
          "MessageEventsAPI"
          "MessageUpdaterAPI"
          "UserSettingsAPI"
          "AlwaysAnimate"
          "WebRichPresence (arRPC)"
          "BetterGifPicker"
          "ClearURLs"
          "FixYoutubeEmbeds"
          "FriendsSince"
          "MoreKaomoji"
          "WebKeybinds"
          "WebScreenShareFixes"
          "WhoReacted"
          "BadgeAPI"
          "NoTrack"
          "DisableDeepLinks"
          "SupportHelper"
          "WebContextMenus"
          "NoOnboardingDelay"
          # "oneko"
        ]
    ));
    notifications = {
      timeout = 5000;
      position = "bottom-right";
      useNative = "not-focused";
      logLimit = 50;
    };
    cloud = {
      authenticated = false;
      settingsSync = false;
    };
  };

  home.packages =
    with pkgs;
    [
      # chat
      signal-desktop
      deltachat-desktop

      # social
      kdePackages.tokodon

      # games
      lutris
      umu-launcher
      feishin # jellyfin client (music)
      gale # thunderstore client
      komikku # comic/manga reader
      everest-mons # celeste mods
      prismlauncher # minecraft
      mcpelauncher-ui-qt # mc bedrock
      # sm64coopdx # since it requires a rom in the nix store; easier to `nix run`
      (tetrio-desktop.override { withTetrioPlus = true; })

      # video
      grayjay
    ]
    ++ (with inputs.nyxexprs.packages.${system}; [
      ani-cli
    ]);
}
