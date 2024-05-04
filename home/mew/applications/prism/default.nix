{ config, pkgs, inputs, lib, ... }: {
  imports = [
    inputs.prism.homeModules.prism
  ];

  options.app.prism.enable = lib.mkEnableOption "prism";
 
  config = lib.mkIf (config.app.prism.enable) {
    prism = {
      enable = true;
      wallpapers = ./wallpapers;
      outPath = "data/Pictures/generated_wallpapers";
      colorscheme = "rose-pine";
    };
  };
}
