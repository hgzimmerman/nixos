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


  environment.systemPackages = with pkgs; [
    nox
    wget
    traceroute
    curl
    acpi
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
    zsh-prezto # Consider moving this into the zsh nix file

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
    extraGroups = [ "audio" "plex"];
  };

# Set the sudo password timeout
  security.sudo.extraConfig = ''
Defaults        env_reset, timestamp_timeout=15
  '';

  # Keep the client from disconnecting by polling the server once a minute
  programs.ssh.extraConfig = "ServerAliveInterval 60";

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  programs.mosh.enable = true;
  services.openssh.ports = [22];
  services.openssh.forwardX11 = true;
  programs.ssh.forwardX11 = true;
  programs.ssh.setXAuthLocation = true;


  networking.networkmanager.enable = true;

}


