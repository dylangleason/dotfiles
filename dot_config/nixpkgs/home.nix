{ config, lib, pkgs, ... }:

let
  defaultFont = "JetBrainsMono Nerd Font 13";
  isLinux = builtins.currentSystem == "x86_64-linux";
in
{
  imports = [./i3.nix ./packages.nix];

  fonts.fontconfig.enable = isLinux;

  home = {
    stateVersion = "21.05";
    username = builtins.getEnv "USER";
    homeDirectory = builtins.getEnv "HOME";
  };

  programs = {
    emacs.enable = true;
    feh.enable = isLinux;
    home-manager.enable = true;

    rofi = {
      enable = isLinux;
      font = defaultFont;
      extraConfig = {
        color-active = "#81a2be,#81a2be,#282a2e,#b294bb,#373b41";
        color-normal = "#373b41,#c5c8c6,#282a2e,#c5c8c6,#373b41";
        color-window = "#373b41,#969896,#969896";
        combi-modi = "window,drun";
        modi = "combi";
        show-icons = true;
        sort = true;
      };
    };

    termite = {
      enable = isLinux;
      font = defaultFont;
    };
  };

  xsession.enable = isLinux;
}
