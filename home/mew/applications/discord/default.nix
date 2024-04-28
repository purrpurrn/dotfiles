{ config, pkgs, ... }: let
  configDir = ".config/discordWebConfig";
  homeDir = "${config.home.homeDirectory}";
in {
  config = {
    xdg.desktopEntries.discord = {
      name = "${pkgs.discord.pname}";
      exec = "${pkgs.chromium}/bin/chromium --user-data-dir=${homeDir}/${configDir} --enable-features=UseOzonePlatform,WebUIDarkMode --ozone-platform=wayland --force-dark-mode --hide-scrollbars --disable-first-run-ui --noerrdialogs --no-first-run --autoplay-policy=no-user-gesture-required --app=https://discord.com/app";
      icon = ./discord.svg;
      genericName = "${pkgs.discord.meta.description}";
      categories = [ "Network" "InstantMessaging" ];
      mimeType = [ "x-scheme-handler/discord" ];
    };
  };
}
