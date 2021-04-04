{ config, pkgs, ... }:

let
  defaultPkgs = with pkgs; [
    ag
    bat
    chezmoi
    cmake
    duf
    font-awesome
    gh
    glibc
    go
    guile
    htop
    ipcalc
    jq
    libtool
    lispPackages.quicklisp
    lsd
    nerdfonts
    oh-my-zsh
    python3
    ruby
    sbcl
    tmux
    tree
  ];
  linuxPkgs = with pkgs; [
    freetype
    papirus-icon-theme
  ];
in
{
  home.packages = if builtins.currentSystem == "x86_64-linux"
                  then (defaultPkgs ++ linuxPkgs)
                  else defaultPkgs;
}
