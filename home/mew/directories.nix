{ config, ... }: let 
  homeDir = "${config.home.homeDirectory}";
in {
  config = {
    home.file."1" = {
      enable = true;
      source = config.lib.file.mkOutOfStoreSymlink "${homeDir}/data/Pictures/memes";
      target = "${homeDir}/1";
    };
    home.file."1-0" = {
      enable = true;
      source = config.lib.file.mkOutOfStoreSymlink "${homeDir}/data/Pictures/memes";
      target = "${homeDir}/data/1";
    };
    home.file."memes" = {
      enable = true;
      source = config.lib.file.mkOutOfStoreSymlink "${homeDir}/data/Pictures/memes";
      target = "${homeDir}/data/Videos/memes";
    };
    home.file."Videos" = {
      enable = true;
      source = config.lib.file.mkOutOfStoreSymlink "${homeDir}/data/Videos";
      target = "${homeDir}/Videos";
    };
    home.file."Pictures" = {
      enable = true;
      source = config.lib.file.mkOutOfStoreSymlink "${homeDir}/data/Pictures";
      target = "${homeDir}/Pictures";
    };
    home.file."Games" = {
      enable = true;
      source = config.lib.file.mkOutOfStoreSymlink "${homeDir}/data/Games";
      target = "${homeDir}/Games";
    };
    home.file."games" = {
      enable = true;
      source = config.lib.file.mkOutOfStoreSymlink "${homeDir}/data/Games";
      target = "${homeDir}/games";
    };
    home.file."Downloads" = {
      enable = true;
      source = config.lib.file.mkOutOfStoreSymlink "/tmp";
      target = "${homeDir}/Downloads";
    };
    home.file."noita_gifs" = {
      enable = true;
      source = config.lib.file.mkOutOfStoreSymlink "${homeDir}/.local/share/Steam/steamapps/compatdata/881100/pfx/dosdevices/c:/users/steamuser/AppData/LocalLow/Nolla_Games_Noita/save_rec/screenshots_animated/";
      target = "${homeDir}/data/Videos/noita_gifs";
    };
    home.file."wallpapers" = {
      enable = true;
      source = config.lib.file.mkOutOfStoreSymlink "./applications/prism/wallpapers";
      target = "${homeDir}/data/Pictures/wallpapers";
    };
    home.file."music" = {
      enable = false;
      source = config.lib.file.mkOutOfStoreSymlink "${homeDir}/data/music";
      target = "${homeDir}/music";
    };

    # Chrome Permission bypass for Downloads Router extension
    home.file."mew" = {
      enable = true;
      source = config.lib.file.mkOutOfStoreSymlink "${homeDir}";
      target = "/tmp";
    };
  };
}
