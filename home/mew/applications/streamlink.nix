{ config, pkgs, lib, ... }: {
  options.streamlink.enable = lib.mkEnableOption "streamlink";

  config = lib.mkIf (config.streamlink.enable) {
    home.packages = [ pkgs.streamlink ];
    xdg.configFile."streamlink/config".text = ''
      player=mpv
    '';
  };
}
