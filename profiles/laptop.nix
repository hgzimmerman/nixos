{ config, pkgs, ... }:
{

  environment.systemPackages = with pkgs; [
    xorg.xbacklight
  ];

services.xserver = {
    synaptics.enable = true;
    synaptics.twoFingerScroll = true;
    synaptics.palmDetect = true;
    synaptics.minSpeed = ".9";
    synaptics.maxSpeed = "1.4";

    displayManager.sessionCommands = ''
      ssh-add
#      ${pkgs.networkmanagerapplet}/bin/nm-applet &;
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


services.postgresql.enable = true;
services.postgresql.authentication = "local all all ident";



}
