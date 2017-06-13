{ config, pkgs, ... }:
{

  networking.hostName = "NixosLaptop"; # Define your hostname.

  # Set your time zone.
  #time.timeZone = "America/New_York";
  time.timeZone = "America/Chicago";

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  programs.mosh.enable = true;
  services.openssh.ports = [2222];
  services.openssh.forwardX11 = true;
  programs.ssh.forwardX11 = true;
  programs.ssh.setXAuthLocation = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;
  services.printing.drivers = [ pkgs.splix pkgs.hplip ];

}
