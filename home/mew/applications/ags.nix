{ config, pkgs, inputs, lib, ... }: {
  imports = [
    inputs.ags.homeManagerModules.default
  ];
 
  options.ags.enable = lib.mkEnableOption "ags";
 
  config = lib.mkIf (config.ags.enable) {
    programs.ags = {
      enable = true;
    };
  };
}
