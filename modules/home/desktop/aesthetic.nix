{
  imports = [
    ./common.nix
    ./themes/koki-o.nix
  ];

  home.pointerCursor = {
    enable = true;
    gtk.enable = true;
    hyprcursor.enable = true;
    x11.enable = true;
  };
}
