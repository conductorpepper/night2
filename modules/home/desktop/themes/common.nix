{ pkgs, lib, ... }:
{
  home.file =
    let
      confine = name: ".night2/${name}";
    in
    {
      ${confine "godot"} = {
        source = pkgs.fetchFromGitHub {
          owner = "passivestar";
          repo = "godot-minimal-theme";
          rev = "2.1.0";
          hash = lib.fakeHash;
        };
      };
      ${confine "inter"} = {
        source = pkgs.fetchFromGitHub {
          owner = "rsms";
          repo = "inter";
          rev = "4.1";
          hash = lib.fakeHash;
        };
      };
    };
}
