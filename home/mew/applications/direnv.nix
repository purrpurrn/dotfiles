{ config, pkgs, lib, ... }: {
  options.direnv.enable = lib.mkEnableOption "direnv";

  config = lib.mkIf (config.direnv.enable) {
    programs.direnv = {
      enable = true;
      enableBashIntegration = true;
      enableNushellIntegration = true;
      enableZshIntegration = true;
    };
  };
}
