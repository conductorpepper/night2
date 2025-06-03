{
  pkgs,
  ...
}:
{
  imports = [
    ./editor.nix
    ./git.nix
    ./lazyvim.nix
    ./shell.nix
  ];

  home.packages = with pkgs; [
    # audio
    bespokesynth
    tenacity

    # game
    trenchbroom
    godot

    # modeling
    blender
    blockbench

    # blender hangs on intel integrated graphics
    # so this is a workaround
    # https://askubuntu.com/questions/1477715/blender-hangs-using-intel-integrated-graphics
    (writeShellScriptBin "blender-igp" ''
      echo 10000 | sudo tee /sys/class/drm/card1/engine/rcs0/preempt_timeout_ms
      INTEL_DEBUG=reemit blender
    '')
  ];
}
