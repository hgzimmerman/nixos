{ config, pkgs, ... }:
{

  # Set your time zone.
  time.timeZone = "America/New_York";
  #time.timeZone = "America/Chicago";

  networking.hostName = "NixosLaptop"; # Define your hostname.

  environment.systemPackages = with pkgs; [
    xorg.xbacklight
    xss-lock # lock when the screen closes
  ];

services.xserver = {
    synaptics.enable = true;
    synaptics.twoFingerScroll = true;
    synaptics.palmDetect = true;
    synaptics.minSpeed = ".9";
    synaptics.maxSpeed = "1.4";

    displayManager.lightdm.enable = true;


    displayManager.sessionCommands = ''

    #set screen timeout lock to an hour.
    ${pkgs.xorg.xset}/bin/xset s 3600
    ${pkgs.xss-lock}/bin/xss-lock -- ${pkgs.i3lock-fancy}/bin/i3lock-fancy -t ""  &

      ssh-add
      # Set GTK_PATH so that GTK+ can find the Xfce theme engine.
      export GTK_PATH=${pkgs.xfce.gtk_xfce_engine}/lib/gtk-2.0

      # Set GTK_DATA_PREFIX so that GTK+ can find the Xfce themes.
      export GTK_DATA_PREFIX=${config.system.path}

      # Set GIO_EXTRA_MODULES so that gvfs works.
      export GIO_EXTRA_MODULES=${pkgs.xfce.gvfs}/lib/gio/modules

      xfsettingsd &
    '';


    videoDrivers = [ "mesa" ];
  };

programs.light.enable = true;

hardware.bluetooth.enable = true;
hardware.pulseaudio.package = pkgs.pulseaudioFull;
hardware.pulseaudio.tcp.enable = true;
hardware.pulseaudio.zeroconf.discovery.enable = true;
hardware.pulseaudio.zeroconf.publish.enable = true;
hardware.pulseaudio.tcp.anonymousClients.allowAll = true;


services.postgresql.enable = true;
services.postgresql.authentication = "local all all ident";

  # Enable CUPS to print documents.
  services.printing.enable = true;
  services.printing.drivers = [ pkgs.splix pkgs.hplip ];


}
