{ config, pkgs, inputs, lib, ... }: let 
  font_family = "Noto Sans";
in {
  imports = [ inputs.hyprlock.homeManagerModules.default ];

  options.app.hyprlock.enable = lib.mkEnableOption "hyprlock";
  
  config = lib.mkIf (config.app.hyprlock.enable) {
    programs.hyprlock = {
      enable = true;

      general.ignore_empty_input = true;
      general.hide_cursor = true;

      backgrounds = [
        {
          monitor = "";
          path = "screenshot";

          # Blur
          blur_passes = 5;
          blur_size = 5;
          noise = 0.03;
        }
      ];

      labels = [
        {
          monitor = "";
          text = "$TIME";
          inherit font_family;
          font_size = 50;
          color = "rgba(200, 200, 200, 1.0)";

          position = {
            x = 0;
            y = 0;
          };

          valign = "center";
          halign = "center";
        }
      ];

      input-fields = [					# Why are input-fields enabled
        { position.x = 5000; position.y = 5000; }	# by default?
      ];						#
    };
  };
}
