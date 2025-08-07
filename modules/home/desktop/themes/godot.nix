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
          rev = "2.3.3";
          hash = "sha256-cdWeuM/VjhC0XyUr5vCfrgepbG9+QPIhZC7RoGQXcds=";
        };
      };
      ${confine "inter"} = {
        source = pkgs.fetchzip {
          url = "https://github.com/rsms/inter/releases/download/v4.1/Inter-4.1.zip";
          hash = "sha256-5vdKKvHAeZi6igrfpbOdhZlDX2/5+UvzlnCQV6DdqoQ=";
          stripRoot = false;
        };
      };
    };
}
