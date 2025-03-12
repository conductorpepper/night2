# https://github.com/juspay/nixos-unified-template/blob/main/modules/home/default.nix
{
  imports =
    builtins.map
    (fn: ./${fn})
    (builtins.filter (fn: fn != "default.nix") (builtins.attrNames (builtins.readDir ./.)));
}
