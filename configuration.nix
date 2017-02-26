# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./neovim.nix
      #./virtualization.nix
    ];


  nixpkgs.config = {
    allowUnfree = true;
  };


  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "HenryNixosLaptop"; # Define your hostname.
  networking.networkmanager.enable = true;

  # Select internationalisation properties.
  i18n = {
    consoleFont = "Lat2-Terminus16";
    consoleKeyMap = "dvorak";
    defaultLocale = "en_US.UTF-8";
  };

  # Set your time zone.
  time.timeZone = "America/New_York";

  programs.zsh.enable = true;


 # virtualisation.docker.enable = true;


  environment = {

    systemPackages = with pkgs; [
      nox
      wget
      traceroute
      curl
      acpi
      evince
      firefox
      zsh
      terminator
      numix-gtk-theme
      numix-icon-theme-circle
      arc-gtk-theme
      vlc
      xsel
      pavucontrol
      moc
      git
      mumble
      docker

      # Languages
      python3
      cmake
      gnumake
      clang
      gcc
      mono
      go
      rustc
      cargo
      nodejs
      texlive.combined.scheme-context

      # Window manager
      rofi
      i3
      lemonbar
      i3blocks
      feh
      pasystray
      slop
      maim
      xorg.xev
      xorg.xprop

      gtk gnome.gnomeicontheme hicolor_icon_theme shared_mime_info

      xfce.exo
      xfce.gtk_xfce_engine
      xfce.gvfs
      xfce.terminal
      xfce.thunar
      xfce.thunar_volman
      xfce.xfce4icontheme
      xfce.xfce4settings
      xfce.xfconf

      # <Polybar dependencies>
      xorg.libXft
      xorg.xcbproto
      xorg.xcbutilwm
      xorg.xcbutilimage
      jsoncpp
      alsaLib
      wirelesstools
      xorg.libX11
      usbutils



      # Vitalization and Passthrough
      #qemu
      #pciutils #lspci
      #win-virtio
      #libvirt
    ];

  shellInit = ''
  '';


  };




  #STEAM and PulseAudio
  hardware = {
    opengl.driSupport32Bit = true; # Steam
    pulseaudio.enable = true; # PA
    pulseaudio.systemWide = true; # VM
    pulseaudio.support32Bit = true; # Steam
  };


  fileSystems."/mnt/media" = {
    device = "192.168.1.125:/plex";
    fsType = "nfs";
    options = ["x-systemd.automount,noauto"];
  };



  # List services that you want to enable:


  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  services.openssh.ports = [2222];

  # Enable CUPS to print documents.
  services.printing.enable = true;
  services.printing.drivers = [ pkgs.splix pkgs.hplip ];

  services.xserver = {
    enable = true;
    layout = "dvorak";
    windowManager.i3.enable = true;
    displayManager.lightdm.enable = true;

    synaptics.enable = true;
    synaptics.twoFingerScroll = true;
    synaptics.palmDetect = true;
    synaptics.minSpeed = ".9";
    synaptics.maxSpeed = "1.4";

    displayManager.sessionCommands = ''
      #xrandr --output DVI-D-0 --right-of DP-4
      #xrandr --output HDMI1 --right-of DP1
      #xrandr --output DP1 --rate 144 --mode 1920x1080
      #xset s 3600 3600
      #xset -dpms

#      ssh-add
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

  fonts = {
    enableFontDir = true;
    fonts = with pkgs; [
      corefonts
      fantasque-sans-mono
      ubuntu_font_family
      font-awesome-ttf
    ];
  };


  users.extraUsers.hzimmerman = {
    isNormalUser = true;
    home = "/home/hzimmerman";
    description = "Henry Zimmerman";
    extraGroups = [ "wheel" "networkmanager" "audio" "docker" ];
    uid = 1000;
  };
  users.extraUsers.root = {
    extraGroups = [ "audio" ];
  };

  users.defaultUserShell = "/run/current-system/sw/bin/zsh";


  # The NixOS release to be compatible with for stateful data such as databases.
  system.stateVersion = "16.09";


}
