# night2

A refactor of my previous configuration for simplicity and cleanliness.

## Hosts

| Host                | System             | Notes               |
|---------------------|--------------------|---------------------|
| weatherstation      | dell inspiron 3880 | previously nikoboat |
| postshelter         | unused             | laptop              |
| anticyclone         | unused             | another pc?         |
| keeper              | virtual machine    | testing             |
| prelude             | N/A                | installer           |

## Modification

You will definitely have to change:

* [user information](./modules/flake/config.nix): make it your own
* [nixos configurations](./configurations/nixos): add a machine here
* [install script](./configurations/nixos/prelude): it's pretty hardcoded

## Install

__Please do not use this without modification; this should be modified for your own machines, identity, and other things.__

Create an ISO file with the following command; the result will be placed in `./result/iso/`.

```nu
nix build github:conductorpepper/night2#nixosConfigurations.prelude.config.system.build.isoImage
```

Write the ISO to a thumb drive, enter the boot option, and run `night2-install`.
The install script will automatically set the disk and configuration up,
but the user password will have to be manually set with `nixos-enter` and `passwd <USER>`
(though something could change with #10).

The install will probably take at least half an hour.

If testing in a VM (particularly virt-manager), use the "keeper" machine.

## Acknowledgements

I based my configuration off of these configurations,
and they help with understanding some stuff.

* [NotAShelf/nyx](https://github.com/NotAShelf/nyx)
* [fufexan/dotfiles](https://github.com/fufexan/dotfiles)
* [ryan4yin/nix-config](https://github.com/ryan4yin/nix-config)
