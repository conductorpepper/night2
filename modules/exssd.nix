{lib, ...}: {
  options.utils.exssd = let
    inherit (lib) mkEnableOption;
  in {
    enable = mkEnableOption "external ssd utils";
  };
}
