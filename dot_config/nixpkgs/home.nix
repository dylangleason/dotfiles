{ config, pkgs, ... }:

{
  imports = if builtins.currentSystem == "x86_64-linux"
            then [./linux.nix]
            else [];

  home = {
    stateVersion = "21.05";
    username = builtins.getEnv "USER";
    homeDirectory = builtins.getEnv "HOME";
    packages =  with pkgs; [
      ag
      chezmoi
      cmake
      duf
      font-awesome
      gh
      glibc
      go
      guile
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
  };

  programs = {
    bat.enable = true;
    emacs.enable = true;
    home-manager.enable = true;
    htop.enable = true;
  };
}
