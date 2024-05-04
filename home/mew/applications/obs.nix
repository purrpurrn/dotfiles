{ config, pkgs, lib, ... }: {
  options.obs.enable = lib.mkEnableOption "obs";

  config = lib.mkIf (config.obs.enable) {
    programs.obs-studio = {
      enable = true;
      plugins = [
        pkgs.obs-studio-plugins.obs-vaapi
      ];
    };
  };
}
