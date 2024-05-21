{ config, pkgs, lib, ... }: {
  options.app.zoxide.enable = lib.mkEnableOption "zoxide";

  config = lib.mkIf (config.app.zoxide.enable) {
    programs.zoxide = {
      enable = true;
      enableFishIntegration = true;
      options = [
        "--cmd cd"
      ];
    };
  };
}
