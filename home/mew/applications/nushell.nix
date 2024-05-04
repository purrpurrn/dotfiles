{ config, pkgs, lib, ... }: {
  options.nushell.enable = lib.mkEnableOption "nushell";

  config = lib.mkIf (config.nushell.enable) {
    programs.nushell = {
      enable = true;
    };
  };
}
