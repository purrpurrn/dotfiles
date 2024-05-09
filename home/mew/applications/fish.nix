{ config, pkgs, lib, ... }: {
  options.app.fish.enable = lib.mkEnableOption "fish";

  config = lib.mkIf (config.app.fish.enable) {
    programs.fish = {
      enable = true;
      interactiveShellInit = ''
        set -g fish_greeting
      '';
    };
  };
}
