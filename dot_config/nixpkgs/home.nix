{ config, pkgs, ... }:

{
  imports = if builtins.currentSystem == "x86_64-linux"
            then [./linux.nix]
            else [];

  home = {
    stateVersion = "22.05";
    username = builtins.getEnv "USER";
    homeDirectory = builtins.getEnv "HOME";
    packages =  with pkgs; [
      chezmoi
      clojure
      duf
      font-awesome
      gh
      go
      ipcalc
      jq
      lsd
      neofetch
      nerdfonts
      oh-my-zsh
      pass
      python3
      silver-searcher
      tmux
      tree
    ];
  };

  programs = {
    bat.enable = true;
    emacs = {
      enable = true;
      extraPackages = epkgs: [epkgs.vterm];
    };
    home-manager.enable = true;
    htop.enable = true;
  };
}
