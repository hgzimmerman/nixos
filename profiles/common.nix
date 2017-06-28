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
    rustc
    cargo
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
    extraGroups = [ "audio" ];
  };


  networking.networkmanager.enable = true;

  programs.zsh.enable = true;
  users.defaultUserShell = "/run/current-system/sw/bin/zsh";

  programs.zsh.interactiveShellInit = ''

    export ZDOTDIR=${pkgs.zsh-prezto}/
    export NIXOS=/etc/nixos/
    export ZSHCONFIG=$NIXOS/dotfiles/zsh

    

    source "$ZDOTDIR/init.zsh"
    source $ZSHCONFIG/zpreztorc
    source "$ZDOTDIR/init.zsh"

  '';

  programs.zsh.promptInit = ''
     autoload -U promptinit && promptinit && prompt ziggy 
  '';

  programs.zsh.shellAliases = {
    la="ls -A";
    lla="ll -A";
    lr="ls -R";
    lx="ll -BX";
    lz="ll -rS";
    no="ls";
    lj="ls *.java";


    Crun="cargo run";
    Ctest="cargo test";


    fastping="ping -c 100 -i .2";
    myip="curl http://ipecho.net/plain; echo";
    ducks="du -cks * | sort -rn | head";

    busy="cat /dev/urandom | hexdump -C | grep 'ca fe'"; 
  };

}


