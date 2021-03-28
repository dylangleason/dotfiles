{ config, pkgs, ... }:

let
  homedir = builtins.getEnv "HOME";
  isLinux = builtins.currentSystem == "x86_64-linux";

  defaultPkgs = with pkgs; [
    ag
    bat
    chezmoi
    duf
    font-awesome
    gh
    go
    guile
    htop
    ipcalc
    jq
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
    polybar
  ];
in
{
  fonts.fontconfig.enable = true;

  home = {
    username = builtins.getEnv "USER";
    homeDirectory = homedir;
    stateVersion = "21.05";
    packages = if isLinux
               then (defaultPkgs ++ linuxPkgs)
               else defaultPkgs;
  };

  programs = {
    emacs.enable = true;
    feh.enable = isLinux;
    home-manager.enable = true;

    rofi = {
      enable = isLinux;
      font = "JetBrainsMono 13";
      extraConfig = {
        drun-icon-theme = "ePapirus";
        show-icons = true;
        sort = true;
      };
    };

    termite = {
      enable = isLinux;
      font = "JetBrains Mono 13";
    };
  };

  xsession.windowManager.i3 = {
    enable = isLinux;
    config = builtins.readFile "${homedir}/.config/i3/config";
  };
}
