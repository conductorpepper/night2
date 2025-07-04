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
      cava
      cmus

      # browser
      wike
      kiwix
      inputs.zen-browser.packages.${system}.default
      netsurf.browser # i like it

      # wine
      wineWowPackages.waylandFull

      # files
      ranger
      unzip
      # ventoy # marked insecure and i don't really need it rn
      file-roller
      impression
      veracrypt
      deja-dup

      # image
      opentabletdriver
      krita
      curtail
      tuxpaint
      aseprite
      glaxnimate

      # writing
      libreoffice-qt
      obsidian
      gnome-text-editor
      apostrophe
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

      # screenshot
      grimblast

      (writeShellScriptBin "areacopy" ''
        grimblast copy area
      '')

      (writeShellScriptBin "areasave" ''
        grimblast save area
      '')

      (writeShellScriptBin "activecopy" ''
        grimblast copy active
      '')

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
    "xdg-open" = "app2unit-open";
  };
}
