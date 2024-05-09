{ config, pkgs, lib, ... }: {
  options.app.nushell.enable = lib.mkEnableOption "nushell";

  config = lib.mkIf (config.app.nushell.enable) {
    programs.nushell = {
      enable = true;
    };
  };
}
