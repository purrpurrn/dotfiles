{ config, pkgs, inputs, lib, ... }: {
  imports = [ inputs.hypridle.homeManagerModules.default ];

  options.hypridle.enable = lib.mkEnableOption "hypridle";

  config = lib.mkIf (config.hypridle.enable) {
    services.hypridle = {
      enable = true;
      lockCmd = "pidof ${pkgs.hyprlock} || ${pkgs.hyprlock}";
      beforeSleepCmd = "${pkgs.systemd}/bin/loginctl lock-session";
      afterSleepCmd = "${pkgs.hyprland}/bin/hyprctl dispatch dpms on";

      listeners = [
        {
	  timeout = 200; # 3,3 minutes
	  onTimeout = "${pkgs.brightnessctl}/bin/brightnessctl -s set 10";
	  onResume = "${pkgs.brightnessctl}/bin/brightnessctl -r";
	}
	{
	  timeout = 300; # 5 minutes
	  onTimeout = "${pkgs.hyprland}/bin/hyprctl dispatch dpms off";
	  onResume = "${pkgs.hyprland}/bin/hyprctl dispatch dpms on";
	}
	{
	  timeout = 540; # 9 minutes
	  onTimeout = "${pkgs.systemd}/bin/loginctl lock-session";
	}
	{
	  timeout = 1800; # 30 minutes
	  onTimeout = "${pkgs.systemd}/bin/systemctl suspend";
	}
      ];
    };
  };
}
