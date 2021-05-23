{ config, lib, pkgs, ...}:

let
  monospaceFont = "JetBrainsMono Nerd Font";
in
{
  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    freetype
    glibc
    glibcLocales
    lxappearance
    lxqt.screengrab
    lxrandr
    papirus-icon-theme
    pcmanfm
  ];
  
  programs = {
    feh.enable = true;
    firefox.enable = true;

    rofi = {
      enable = true;
      font = "${monospaceFont} 13";
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
      enable = true;
      font = "${monospaceFont} 13";
      backgroundColor = "#1d1f21";
      foregroundColor = "#c5c8c6";
      foregroundBoldColor = "#c5c8c6";
      cursorColor = "#c5c8c6";
      cursorForegroundColor = "#c5c8c6";
      colorsExtra = ''
      # 16 color space
      
      # Black, Gray, Silver, White
      color0  = #1d1f21
      color8  = #969896
      color7  = #c5c8c6
      color15 = #ffffff
      
      # Red
      color1  = #cc6666
      color9  = #cc6666
      
      # Green
      color2  = #b5bd68
      color10 = #b5bd68
      
      # Yellow
      color3  = #f0c674
      color11 = #f0c674
      
      # Blue
      color4  = #81a2be
      color12 = #81a2be
      
      # Purple
      color5  = #b294bb
      color13 = #b294bb
      
      # Teal
      color6  = #8abeb7
      color14 = #8abeb7
      
      # Extra colors
      color16 = #de935f
      color17 = #a3685a
      color18 = #282a2e
      color19 = #373b41
      color20 = #b4b7b4
      color21 = #e0e0e0
      '';
    };    
  };

  services.emacs = {
    enable = true;
    client.enable = true;
    socketActivation.enable = true;
  };

  xsession.enable = true;
  xsession.windowManager.i3 = {
    enable = true;
    package = pkgs.i3-gaps;

    config = rec {
      fonts = ["${monospaceFont} 8" "${monospaceFont} 10"];
      modifier = "Mod4";

      gaps = {
        inner = 8;
        outer = 0;
        smartBorders = "on";
        smartGaps = true;
      };

      keybindings = lib.mkOptionDefault {
        "${modifier}+d" = "exec \"rofi -show combi\"";
        "${modifier}+j" = "focus left";
        "${modifier}+k" = "focus down";
        "${modifier}+l" = "focus up";
        "${modifier}+Return" = "exec termite";
        "${modifier}+semicolon" = "focus right";
        "${modifier}+Shift+j" = "move left";
        "${modifier}+Shift+k" = "move down";
        "${modifier}+Shift+l" = "move up";
        "${modifier}+Shift+semicolon" = "move right";
      };

      bars = [
        {
          position = "top";
          statusCommand = "${pkgs.i3status-rust}/bin/i3status-rs";
        }
      ];

      startup = [
        {
          command = "exec i3-msg workspace 1";
          always = true;
          notification = false;
        }

        {
          command = "feh --bg-scale ${builtins.getEnv "HOME"}/desktop_image.png";
          always = true;
          notification = false;
        }
      ];
    };
  };
}
