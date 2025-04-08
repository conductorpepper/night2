# night2

A refactor of my previous configuration for simplicity and cleanliness.

Please do not use this without modification; this should be modified for a certain system.

## Hosts

| Host                | System             | Notes               |
|---------------------|--------------------|---------------------|
| weatherstation      | dell inspiron 3880 | previously nikoboat |
| postshelter         | unused             | laptop              |
| anticyclone         | unused             | another pc?         |
| keeper              | virtual machine    | testing             |
| prelude             | N/A                | installer           |

## Creating an ISO

```nu
git clone "https://github.com/conductorpepper/night2"
cd night2
nix build .#nixosConfigurations.prelude.config.system.build.isoImage # the only essential line
```

## Acknowledgements

I based my configuration off of these configurations,
and they help with understanding some stuff.

* [NotAShelf/nyx](https://github.com/NotAShelf/nyx)
* [fufexan/dotfiles](https://github.com/fufexan/dotfiles)
* [ryan4yin/nix-config](https://github.com/ryan4yin/nix-config)
