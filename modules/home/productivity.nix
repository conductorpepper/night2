{
  flake,
  pkgs,
  ...
}: let
  inherit (flake) inputs;
  inherit (flake.inputs) self;
in {
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

  home.packages = let
    system = pkgs.stdenv.hostPlatform.system;
  in
    with pkgs; [
      # audio
      easyeffects
      cava
      cmus

      # browser
      wike
      kiwix
      inputs.zen-browser.packages.${system}.default

      # wine
      wineWowPackages.waylandFull

      # files
      ranger
      unzip
      ventoy
      file-roller
      impression

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

      # mail
      thunderbird

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
      yt-dlp

      # learning
      anki-bin

      # fonts
      roboto
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
      inter
      commit-mono
      (nerdfonts.override {fonts = ["JetBrainsMono"];})
      cozette
      tewi-font
      terminus_font
      self.packages.${system}.middle-mann-fonts
    ];
}
