{ config, pkgs, ... }:
{
# This config file should contain packages and settings that should apply to all possible configurations.
# If there is something that conflicts between environments, then in should be enumerated in those specific environments.



 # Select internationalisation properties.
  i18n = {
    consoleFont = "Lat2-Terminus16";
    consoleKeyMap = "dvorak";
    defaultLocale = "en_US.UTF-8";
  };

  nixpkgs.config.packageOverrides = pkgs: rec {
    oraclejdk8 = pkgs.openjdk8;
    rustNightly = pkgs.callPackage /etc/nixos/customPkgs/rust {};
    rustLatest = rustNightly.rust {};
  }; 

  nixpkgs.config.allowBroken = true; # Required if building using unstable channel

  environment.systemPackages = with pkgs; [
    nox
    wget
    traceroute
    curl
    sshuttle
    acpi
    usbutils
    coreutils
    git
    htop
    zip
    unzip
    unrar
    p7zip
    tree
    tmux
    screen
    psmisc # killall
    python35Packages.youtube-dl
    zsh-prezto # Consider moving this into the zsh nix file
    keybase
    keybase-gui
    kbfs

    idea.idea-community

    binutils
    # Languages
    python3
    python2
    ruby
    openjdk
    cmake
    gnumake
    clang
    gcc
    mono
    go
    pandoc
    openssl
    rustup

    nix-repl

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
#        collection-genericextra
        collection-bibtexextra
        collection-binextra
        collection-context
        collection-formatsextra
        collection-fontutils
#        collection-genericrecommended
        collection-langcyrillic
        collection-langenglish
        collection-latex
        collection-latexextra
        collection-latexrecommended
        collection-mathscience
        collection-pictures
#        collection-plainextra
#        collection-pstricks
#        collection-science
        collection-xetex;
    })

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
      comic-neue
      nerdfonts
    ];
  };

  users.extraUsers.hzimmerman = {
    isNormalUser = true;
    home = "/home/hzimmerman";
    description = "Henry Zimmerman";
    extraGroups = [ "wheel" "networkmanager" "audio" "docker" "plex"];
    uid = 1000;
  };
  # I believe that root needs to be in the audio group to make pulseaudio work for some applications.
  users.extraUsers.root = {
    extraGroups = [ "audio" "plex" "plugdev"];
  };

# Set the sudo password timeout
  security.sudo.extraConfig = ''
Defaults        env_reset, timestamp_timeout=15
  '';

  # Keep the client from disconnecting by polling the server once a minute
  programs.ssh.extraConfig = "ServerAliveInterval 60";

  services.keybase.enable = true;
  services.kbfs.enable = true;
  services.kbfs.mountPoint = "/keybase";

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  programs.mosh.enable = true;
  services.openssh.ports = [22];
  services.openssh.forwardX11 = true;
  programs.ssh.forwardX11 = true;
  programs.ssh.setXAuthLocation = true;


  networking.networkmanager.enable = true;

}
