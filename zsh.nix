{ config, pkgs, ... }:
{

  programs.zsh.enable = true;
  users.defaultUserShell = "/run/current-system/sw/bin/zsh";


  programs.zsh.interactiveShellInit = ''

    export ZDOTDIR=${pkgs.zsh-prezto}/
    export NIXOS=/etc/nixos/
    export ZSHCONFIG=$NIXOS/dotfiles/zsh


    source $ZSHCONFIG/zpreztorc
    source "$ZDOTDIR/init.zsh"


    source $ZSHCONFIG/zsh_functions

  '';

  programs.zsh.promptInit = ''
     autoload -U promptinit && promptinit && prompt ziggy_nerd 
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
    ducks="du -cksh * | sort -rn | head";

    busy="cat /dev/urandom | hexdump -C | grep 'ca fe'"; 


    ga="git add";
    gp="git push";
    gl="git pull";
    gd="git diff";
    gst="git status";
    gss="git status -s";
    glog="git log --oneline --decorate --graph";
    grh="git reset HEAD";
    glum="git pull upstream master";
    gwch="git whatchanged -p --abbrev-commit --pretty=medium";
    

  };



}
