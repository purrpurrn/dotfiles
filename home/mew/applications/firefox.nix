{ config, pkgs, inputs, lib, ... }: {
  imports = [ inputs.schizofox.homeManagerModule ];

  options.app.firefox.enable = lib.mkEnableOption "firefox";

  config = lib.mkIf (config.app.firefox.enable) {
    programs.schizofox = {
      enable = true;
    };
  };
}
