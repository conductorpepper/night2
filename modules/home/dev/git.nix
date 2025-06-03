{ flake, ... }:
{
  programs.git =
    let
      user = flake.config.me;
    in
    {
      enable = true;
      userEmail = user.email;
      userName = user.username;
    };

  programs.gh = {
    enable = true;
    gitCredentialHelper.enable = true;
  };
}
