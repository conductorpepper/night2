{
  imports = [
    ./themes/rose-pine-moon.nix
  ];

  home.pointerCursor = {
    enable = true;
    gtk.enable = true;
    hyprcursor.enable = true;
    x11.enable = true;
  };
}
