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
      font = "JetBrainsMono Nerd Font 13";
      extraConfig = {
        color-active = "#81a2be,#81a2be,#282a2e,#b294bb,#373b41";
        color-normal = "#373b41,#c5c8c6,#282a2e,#c5c8c6,#373b41";
        color-window = "#373b41,#969896,#969896";
        combi-modi = "window,run";
        modi = "combi";
        show = "combi";
        sort = true;
      };
    };

    termite = {
      enable = isLinux;
      font = "JetBrainsMono Nerd Font 13";
    };
  };

  xsession.windowManager.i3 = {
    enable = isLinux;
  };
}
