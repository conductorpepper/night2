{
  flake,
  pkgs,
  ...
}:
{
  xdg.configFile."quickshell/caelestia".source = pkgs.fetchFromGitHub {
    owner = "caelestia-dots";
    repo = "shell";
    rev = "bef79bde1f56d42e551424ffb061fe3f76fe5ea6";
    hash = "sha256-/+R8UfKhEogRq94WLIC8nWmKgDdadXSoKQqLQkeBPTY=";
  };

  programs.git.enable = true;
  programs.fish.enable = true;

  wayland.windowManager.hyprland.settings = {
    layerrule = [
      "noanim, caelestia-(launcher|osd|notifications|border-exclusion)"
      "animation fade, caelestia-(drawers|background)"
      "order 1, caelestia-border-exclusion"
      "order 2, caelestia-bar"
    ];
  };

  home.packages =
    [
      flake.inputs.quickshell.packages.${pkgs.stdenv.hostPlatform.system}.default
    ]
    ++ (with pkgs; [
      app2unit
      material-symbols
      nerd-fonts.jetbrains-mono
      ibm-plex
      curl
      jq
      fd
      cava
      bluez
      ddcutil
      brightnessctl
      imagemagick
    ])
    ++ (with pkgs.python313Packages; [
      aubio
      pyaudio
      numpy
    ]);
}
