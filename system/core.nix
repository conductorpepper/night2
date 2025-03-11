{pkgs, ...}: {
  # bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.supportedFilesystems = ["ntfs" "btrfs"];

  # internationalisation
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # input
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5.addons = with pkgs; [
      # gui
      fcitx5-gtk

      # languages
      fcitx5-mozc
    ];
  };

  # user
  users.users.ri = {
    isNormalUser = true;
    description = "rimail";
    shell = pkgs.zsh;
    extraGroups = [
      "networkmanager"
      "wheel"
      "video"
      "scanner"
      "lp"
      "libvirtd"
      "cdrom"
      "gamemode"
    ];
  };

  # shell
  programs.zsh.enable = true;
  environment.pathsToLink = ["/share/zsh"];

  environment.shells = with pkgs; [
    nushell
  ];

  environment.systemPackages = with pkgs; [
    vim
    git
    gh
    wget
    just

    kilall
  ];
}
