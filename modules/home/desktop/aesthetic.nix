{pkgs, ...}: {
  home.pointerCursor = {
    enable = true;
    package = pkgs.rose-pine-hyprcursor;
    name = "rose-pine-hyprcursor"; # only dark for now
    gtk.enable = true;
    hyprcursor.enable = true;
    x11.enable = true;
  };
}
