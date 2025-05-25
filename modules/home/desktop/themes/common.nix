{ pkgs, ... }:
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
          hash = "sha256-+tip0xye1S3X0cZRsMI14s+1XM4tHNiSptA4nGGqoZY=";
        };
      };
      ${confine "inter"} = {
        source = pkgs.fetchFromGitHub {
          owner = "rsms";
          repo = "inter";
          rev = "v4.1";
          hash = "sha256-HXb08JjES2+80+lJ5w46yX8sP9Jh5V+DBlbdKQfdpLw=";
        };
      };
    };
}
