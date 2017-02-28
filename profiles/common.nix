{ config, pkgs, ... }:
{


 # Select internationalisation properties.
  i18n = {
    consoleFont = "Lat2-Terminus16";
    consoleKeyMap = "dvorak";
    defaultLocale = "en_US.UTF-8";
  };


  environment.systemPackages = with pkgs; [
    nox
    wget
    traceroute
    curl
    acpi
    docker
    usbutils
    git
    htop
    zip
    unzip
    unrar
    p7zip


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


  ];

  virtualisation.docker.enable = true;


  # Fonts are in common.nix, because even though a sever may not have an x environment, using supported fonts is nice
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


  networking.networkmanager.enable = true;

  programs.zsh.enable = true;
  users.defaultUserShell = "/run/current-system/sw/bin/zsh";

}

