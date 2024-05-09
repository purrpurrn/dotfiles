{ config, pkgs, inputs, lib, ... }: {
  imports = [
    inputs.ags.homeManagerModules.default
  ];
 
  options.app.ags.enable = lib.mkEnableOption "ags";
 
  config = lib.mkIf (config.app.ags.enable) {
    programs.ags = {
      enable = true;
    };
  };
}
