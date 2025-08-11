{ flake, pkgs, ... }:
let
  inherit (flake) inputs;
in
{
  imports = [
    inputs.zen-browser.homeModules.twilight
  ];

  programs.zen-browser.enable = true;

  programs.zen-browser.nativeMessagingHosts = with pkgs; [
    kdePackages.plasma-browser-integration
  ];

  programs.zen-browser.policies = {
    DefaultDownloadDirectory = "/home/${flake.config.me.username}/Downloads";
    DisableAppUpdate = true;
    DisableFeedbackCommands = true;
    DisableFirefoxStudies = true;
    DisablePocket = true;
    DisableTelemetry = true;
    DontCheckDefaultBrowser = true;
    NoDefaultBookmarks = true;
    AutofillAddressEnabled = false;
    AutofillCreditCardEnabled = false;
    OfferToSaveLogins = false; # may interfere with keepassxc?
    EnableTrackingProtection = {
      Value = true;
      Locked = true;
      Cryptomining = true;
      Fingerprinting = true;
      Category = "strict";
    };
  };

  programs.zen-browser.policies.Preferences = { };

  # https://addons.mozilla.org/api/v5/addons/addon/NAME/
  programs.zen-browser.policies.ExtensionSettings =
    let
      extension = name: guid: extra: {
        inherit name;
        value = {
          installation_mode = "force_installed";
          install_url = "https://addons.mozilla.org/firefox/downloads/latest/${name}/latest.xpi";
        }
        // extra;
      };
    in
    builtins.listToAttrs [
      (extension "ublock-origin" "uBlock0@raymondhill.net" { private_browsing = true; })
      (extension "keepassxc-browser" "keepassxc-browser@keepassxc.org" { private_browsing = true; })
      (extension "indie-wiki-buddy" "{cb31ec5d-c49a-4e5a-b240-16c767444f62}" { private_browsing = true; })
      (extension "vimium-ff" "{d7742d87-e61d-4b78-b8a1-b469842139fa}" { private_browsing = true; })
      (extension "yomitan" "{6b733b82-9261-47ee-a595-2dda294a4d08}" { private_browsing = true; })
      (extension "sponsorblock" "sponsorBlocker@ajay.app" { })
      (extension "return-youtube-dislikes" "{762f9885-5a13-4abd-9c77-433dcd38b8fd}" { })
      (extension "plasma-integration" "plasma-browser-integration@kde.org" { private_browsing = true; })
    ];
}
