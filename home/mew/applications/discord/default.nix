{ config, pkgs, lib, ... }: let
  configDir = ".config/discordWebConfig";
  homeDir = "${config.home.homeDirectory}";
in {
  imports = [
    ./vesktop.nix
    ./test.nix
  ];

  config = {
    programs.vesktop = {
      enable = true;
      settings = {
#        autoUpdate = false;
#	autoUpdateNotification = false;
#	useQuickCss = true;
#	enableReactDevtools = true;
#	frameless = true;
#	transparent = false;
#	winCtrlQ = false;
        splashBackground = "rgb(15, 15, 15)";
      };
      quickCSS = ./m.css;
    };
  };
}
