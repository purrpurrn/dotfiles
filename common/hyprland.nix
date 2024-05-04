{ config, pkgs, inputs, ... }: {
  config = {
    programs.hyprland = {
      enable = true;
      package = inputs.hyprland.packages."x86_64-linux".hyprland;
      xwayland.enable = true;
    };
    xdg.portal = {
      enable = true;
      extraPortals = [
	pkgs.xdg-desktop-portal-gnome
      ];
    };
  };
}
