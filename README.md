# nixos

This is my set of configuration files for Nixos.
I use these files across three separate computers:
* A desktop with a graphics card and multiple monitors, where I sometimes run Windows games using QEMU + VIFO passthrough.
* A Dell XPS13 laptop.
* A home media server that uses zfs for its filesystem and Plex for serving media.

As part of this setup, I have tried to roll as many configurable programs into my configuration.
You will find that the configs for i3, zsh, and neovim are all contained within this configuration, instead of `~/`.

## Installation
* `git clone` this project to `/etc/nixos/`.
* You may want to edit the config before rebuilding ( look in `profiles/common.nix`).
  * You will likely want to set the default keymapping to something other than Dvorak.
  * You will want to change the default user.
* Set the appropriate features you want in `configuration.nix` by uncommenting the `.nix` files you wish to use.
* run `sudo nixos-rebuild switch`
* enjoy
