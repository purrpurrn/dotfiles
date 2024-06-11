{ config, pkgs, lib, inputs, ... }: {
  imports = [
    inputs.stylix.homeManagerModules.stylix
  ];

  config = {
    stylix.autoEnable = true;
    
    stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/rose-pine.yaml";

    stylix.targets.kitty = {
      variant256Colors = true;
    };

    stylix.image = ./prism/wallpapers/6.jpg;

    stylix.cursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Classic";
    };

    stylix.opacity = {
        applications = 1.0;
	terminal = 0.9;
	desktop = 1.0;
	popups = 1.0;
    };

    stylix.fonts = {
      sizes = {
        applications = 12;
	terminal = 13;
	desktop = 12;
	popups = 10;
      };

      monospace = {
        package = pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; };
        name = "JetbrainsMono Nerd Font";
      };
      sansSerif = {
        package = pkgs.source-sans;
	name = "Source Sans";
      };
      serif = {
        package = pkgs.source-serif;
	name = "Source Serif";
      };
    };
  };
}
