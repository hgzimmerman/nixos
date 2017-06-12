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
    tree
    psmisc # killall
    python35Packages.youtube-dl
    zsh-prezto


    idea.idea-community

    # Languages
    python3
    ruby
    openjdk
    cmake
    gnumake
    clang
    gcc
    mono
    go
  #  rustNightly.rustc
  # rustNightly.cargo
    nodejs
    gnuplot
    (texlive.combine {
      inherit (texlive)
        collection-basic
        metafont
        xits
        graphics
        amsmath
        collection-bibtexextra
        collection-binextra
        collection-context
        collection-formatsextra
        collection-fontutils
        collection-genericextra
        collection-genericrecommended
        collection-langcyrillic
        collection-langenglish
        collection-latex
        collection-latexextra
        collection-latexrecommended
        collection-mathextra
        collection-pictures
        collection-plainextra
        collection-pstricks
        collection-science
        collection-xetex;
    })

  ];

  nixpkgs.config.packageOverrides = pkgs: { oraclejdk8 = pkgs.openjdk8; }; 
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
    extraGroups = [ "wheel" "networkmanager" "audio" "docker" "plex"];
    uid = 1000;
  };
  users.extraUsers.root = {
    extraGroups = [ "audio" "plex"];
  };


  networking.networkmanager.enable = true;

  programs.zsh.enable = true;
  users.defaultUserShell = "/run/current-system/sw/bin/zsh";
  #programs.zsh.shellInit = "";
 # programs.zsh.interactiveShellInit = "source /etc/nixos/dotfiles/zsh/zshrc";


    
}

