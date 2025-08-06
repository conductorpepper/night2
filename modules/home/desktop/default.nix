{
  imports = [
    ./themes/godot.nix
    ./plasma.nix
  ];

  home.pointerCursor = {
    enable = false;
    gtk.enable = true;
    hyprcursor.enable = true;
    x11.enable = true;
  };

  stylix.targets = {
    zen-browser.enable = false;
  };
}
