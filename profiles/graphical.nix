{ config, pkgs, ... }:





{
  nixpkgs.config = {
    firefox = {
      enableOfficalBranding = true;
    };



  };



  environment.systemPackages = with pkgs; [


    #User Programs
    evince
    firefox
    vivaldi
    zsh
    terminator
    vlc
    pavucontrol
    gnome3.nautilus
    tdesktop # telegram
    xarchive
    mplayer
    mpv

    vscode
    atom

    #Printer Drivers
    hplip

    # Window manager
    rofi
    rofi-menugen
    i3
    networkmanagerapplet
    lemonbar
    i3blocks
    polybar
    feh
    pasystray
    slop
    maim
    xorg.xev
    xorg.xprop
    i3lock # The lock that is activated when the screen closes
    i3lock-fancy
    lightlocker
    xsel
    redshift

    #Misc xfce things
    xfce.exo
    xfce.gtk_xfce_engine
    xfce.gvfs
    xfce.terminal
    xfce.thunar
    xfce.thunar_volman
    xfce.xfce4icontheme
    xfce.xfce4settings
    xfce.xfconf


    #Themes
#    gtk gnome.gnomeicontheme
    hicolor_icon_theme shared_mime_info

    numix-gtk-theme
    numix-icon-theme-circle
    arc-theme
    adapta-gtk-theme

  ];
nixpkgs.config.packageOverrides = pkgs: {
    polybar = pkgs.polybar.override {
      i3Support = true;
      iwSupport = true;
      mpdSupport = true;
    };
  };

  #STEAM and PulseAudio
  hardware = {
    opengl.driSupport32Bit = true; # Steam
    pulseaudio.enable = true; # PA
    pulseaudio.systemWide = true; # VM
    pulseaudio.support32Bit = true; # Steam
  };


  services.xserver = {
    enable = true;
    layout = "dvorak";
    windowManager.i3.enable = true;
    windowManager.i3.configFile = /etc/nixos/dotfiles/i3/i3config;
    displayManager.lightdm.enable = true;
  };
  

  services.redshift = {
    enable = true;
    latitude = "43.03817561648102";
    longitude = "-77.71419525146484";
    temperature.day = 6200;
    temperature.night = 3800;
    brightness.night = ".9";
  };


}
