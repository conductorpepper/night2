# night2

___NixOS Configuration V3___

A heavy refactor of my previous configuration for simplicity and cleanliness, starting almost completely from scratch.

A single-user flake-parts flake that follows unstable.

## Exports

This flake exports a few [packages](./packages/) and [modules](./modules/) (quality varies) that are not present in nixpkgs.

## Hosts

| Host                | System             | Notes               |
|---------------------|--------------------|---------------------|
| weatherstation      | dell inspiron 3880 | previously nikoboat |
| postshelter         | unused             | laptop              |
| anticyclone         | unused             | another pc?         |
| keeper              | virtual machine    | testing             |

## Acknowledgements

* [NotAShelf/nyx](https://github.com/NotAShelf/nyx)
* [fufexan/dotfiles](https://github.com/fufexan/dotfiles)
* [ryan4yin/nix-config](https://github.com/ryan4yin/nix-config)
