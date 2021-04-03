{ config, lib, pkgs, ... }:

{
  xsession.windowManager.i3 = {
    enable = builtins.currentSystem == "x86_64-linux";

    config = rec {
      fonts = ["monospace 8" "DejaVu Sans Mono 10"];
      modifier = "Mod4";

      keybindings = lib.mkOptionDefault {
        "${modifier}+d" = "exec \"rofi -show combi\"";
        "${modifier}+j" = "focus left";
        "${modifier}+k" = "focus down";
        "${modifier}+l" = "focus up";
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
      ];
    };
  };
}
