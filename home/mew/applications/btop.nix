{ config, pkgs, lib, ... }: {
  options.app.btop.enable = lib.mkEnableOption "btop";
 
  config = lib.mkIf (config.app.btop.enable) {
    programs.btop = {
      enable = true;
      settings = {
        theme_background = false;
	truecolor = true;
      };
    };
  };
}
