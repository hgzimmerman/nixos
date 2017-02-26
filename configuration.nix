# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./neovim.nix
      ./profiles/common.nix
      ./profiles/graphical.nix
      #./profiles/laptop.nix
      ./profiles/desktop.nix
      ./virtualization.nix
    ];


  nixpkgs.config = {
    allowUnfree = true;
  };


  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "HenryNixosLaptop"; # Define your hostname.
  networking.networkmanager.enable = true;


  # Set your time zone.
  time.timeZone = "America/New_York";



  # List services that you want to enable:


  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  services.openssh.ports = [2222];

  # Enable CUPS to print documents.
  services.printing.enable = true;
  services.printing.drivers = [ pkgs.splix pkgs.hplip ];

  
 
  # The NixOS release to be compatible with for stateful data such as databases.
  system.stateVersion = "16.09";


}
