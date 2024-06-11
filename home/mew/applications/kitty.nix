{ config, pkgs, lib, ... }: {
  options.app.kitty.enable = lib.mkEnableOption "kitty";

  config = lib.mkIf (config.app.kitty.enable) {
    programs.kitty = {
      enable = true;
      shellIntegration = {
        enableFishIntegration = true;
	enableBashIntegration = true;
	enableZshIntegration = true;
      };
      settings = {
        cursor_shape = "beam";
	show_hyperlink_targets = true;
	enable_audio_bell = false;
	#background_blur = "2";
	shell = "fish";
	editor = "nvim";
	confirm_os_window_close = "0";
	#font_features = "FiraCode +cv02 +cv05 +cv09 +cv14 +ss04 +cv16 +cv31 +cv25 +cv26 +cv32 +cv28 +ss10 +zero +onum";
      };
      theme = "Rosé Pine";
    };
  };
}
