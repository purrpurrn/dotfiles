{ config, pkgs, lib, ... }: {
  options.app.obs.enable = lib.mkEnableOption "obs";

  config = lib.mkIf (config.app.obs.enable) {
    programs.obs-studio = {
      enable = true;
      plugins = [
        pkgs.obs-studio-plugins.obs-vaapi
      ];
    };
  };
}
