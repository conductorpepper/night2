{flake, ...}: let
  inherit (flake) config;
in {
  home-manager.users.${config.utils.user.username} = {};
}
