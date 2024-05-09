{ config, pkgs, lib, ... }: {
  options.app.streamlink.enable = lib.mkEnableOption "streamlink";

  config = lib.mkIf (config.app.streamlink.enable) {
    home.packages = [ pkgs.streamlink ];
    xdg.configFile."streamlink/config".text = ''
      player=mpv
    '';
  };
}
