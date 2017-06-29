{ config, pkgs, ... }:
{

  # Set your time zone.
  #time.timeZone = "America/New_York";
  time.timeZone = "America/Chicago";

  networking.hostName = "NixosDesktop"; # Define your hostname.

  environment.systemPackages = with pkgs; [
    moc
    mumble
    steam
    docker
    xorg.xf86videointel
  ];

  fileSystems."/mnt/media" = {
    device = "192.168.1.125:/plex";
    fsType = "nfs";
    options = ["x-systemd.automount,noauto"];
  };

services.xserver = {
    displayManager.sessionCommands = ''
      xrandr --output HDMI-1 --right-of DP-1
      xrandr --output DP-1 --rate 144 --mode 1920x1080 --primary
      xset s 3600 3600
      xset -dpms

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
#    videoDrivers = [ "nvidia" ];
  };

  virtualisation.docker.enable = true;




  # Enable CUPS to print documents.
  services.printing.enable = true;
  services.printing.drivers = [ pkgs.splix pkgs.hplip ];


}
