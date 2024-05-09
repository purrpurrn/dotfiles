{ config, pkgs, lib, ... }: {
  options.app.direnv.enable = lib.mkEnableOption "direnv";

  config = lib.mkIf (config.app.direnv.enable) {
    programs.direnv = {
      enable = true;
      enableBashIntegration = true;
      enableNushellIntegration = true;
      enableZshIntegration = true;
    };
  };
}
