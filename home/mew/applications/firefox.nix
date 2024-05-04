{ config, pkgs, inputs, lib, ... }: {
  imports = [ inputs.schizofox.homeManagerModule ];

  options.firefox.enable = lib.mkEnableOption "firefox";

  config = lib.mkIf (config.firefox.enable) {
    programs.schizofox = {
      enable = true;
    };
  };
}
