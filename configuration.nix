# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./neovim.nix
      ./zsh.nix
      ./profiles/common.nix
      ./profiles/graphical.nix
      #./profiles/laptop.nix
      ./profiles/desktop.nix
      #./profiles/server.nix
      #./virtualization.nix
    ];


  nixpkgs.config = {
    allowUnfree = true;
  };


  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
 
  # The NixOS release to be compatible with for stateful data such as databases.
  system.stateVersion = "17.03";

}
