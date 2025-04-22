{config, pkgs, ...}: {
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;

    gamescopeSession.enable = true;
    gamescopeSession.args = [
      "-O ${(builtins.concatStringsSep "," config.utils.monitors.monitors)}"
    ];
  };

  programs.gamescope = {
    enable = true;
    capSysNice = true;
  };

  programs.gamemode.enable = true;

  # <replay here>

  # extra utilities
  environment.systemPackages = with pkgs; [
    mangohud
  ];
}
