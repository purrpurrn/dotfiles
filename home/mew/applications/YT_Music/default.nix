{ config, pkgs, lib, ... }: let
  configDir = ".config/YTMusicWebConfig";
  homeDir = "${config.home.homeDirectory}";
in {
  options.YTMusic.enable = lib.mkEnableOption "YTMusic";

  config = lib.mkIf (config.YTMusic.enable) {
    xdg.desktopEntries.YTMusic = {
      name = "Youtube Music";
      exec = "${pkgs.chromium}/bin/chromium --user-data-dir=${homeDir}/${configDir} --enable-features=UseOzonePlatform,WebUIDarkMode --ozone-platform=wayland --force-dark-mode --hide-scrollbars --disable-first-run-ui --noerrdialogs --no-first-run --autoplay-policy=no-user-gesture-required --deny-permission-prompts --app=https://music.youtube.com";
      icon = ./ytmusic.svg;
      genericName = "Youtube Music";
      categories = [ "Network" "Audio" ];
    };
  };
}
