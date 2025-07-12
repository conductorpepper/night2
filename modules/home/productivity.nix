{
  flake,
  pkgs,
  ...
}:
let
  inherit (flake) inputs;
in
{
  home.sessionVariables = {
    # wayland
    NIXOS_OZONE_WL = "1";
    MOZ_ENABLE_WAYLAND = "1";
  };

  programs.obs-studio = {
    enable = true;
    plugins = with pkgs.obs-studio-plugins; [
      wlrobs
      obs-pipewire-audio-capture
      obs-vkcapture
    ];
  };

  home.packages =
    let
      system = pkgs.stdenv.hostPlatform.system;
    in
    with pkgs;
    [
      # audio
      easyeffects

      # browser
      wike
      kiwix
      inputs.zen-browser.packages.${system}.default

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

      # writing
      libreoffice-qt
      obsidian
      logseq
      zathura
      hunspell
      hunspellDicts.en_US
      pdftk

      # mail
      thunderbird
      tutanota-desktop
      protonmail-desktop # ...

      # pass
      keepassxc

      # video
      vlc
      mpv
      davinci-resolve
      kdePackages.kdenlive
      flowblade
      yt-dlp

      # learning
      anki-bin

      # reading
      kdePackages.okular # set explicitly
      qpdfview
      mupdf

      # computer
      btop

      # meetings
      zoom-us

      # desktop things
      app2unit
    ];

  home.shellAliases = {
    # "xdg-open" = "app2unit-open";
  };
}
