# middle mann is a tf2 hud
{
  stdenv,
  fetchFromGitHub,
  lib,
}: let
  owner = "Vexcenot";
  repo = "-Middle-Mann";
  rev = "v23";
  hash = "sha256-KJTatYMc11HamdYitPDM5jlRW0qHBQkAGu6kqyQ1Skk=";

  pname = "middle-mann-fonts";

  src = fetchFromGitHub {
    inherit owner repo rev hash;
  };
in
  stdenv.mkDerivation {
    inherit pname src;
    version = rev;

    dontBuild = true;

    installPhase = ''
      runHook preInstall

      install -Dm644 $src/resource/fonts/*.ttf -t $out/share/fonts/truetype

      runHook postInstall
    '';

    meta = {
      homepage = "https://github.com/Vexcenot/-Middle-Mann";
      license = lib.licenses.unfree;
    };
  }
