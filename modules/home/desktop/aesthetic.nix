{
  imports = [
    ./themes/basic.nix
    ./themes/common.nix
  ];

  home.pointerCursor = {
    enable = false;
    gtk.enable = true;
    hyprcursor.enable = true;
    x11.enable = true;
  };
}
