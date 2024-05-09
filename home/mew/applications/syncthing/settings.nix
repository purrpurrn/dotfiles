{ config, pkgs, inputs, lib, ... }: let
  homeDir = "${config.home.homeDirectory}";
in {
  options.app.syncthing.enable = lib.mkEnableOption "syncthing";
 
  config = lib.mkIf (config.app.syncthing.enable) {
    services.syncthing = {
      reallyEnable = true;
      overrideDevices = true;
      devices = {
        "AsM" = { id = "FS3UO7Y-BZO3QBZ-THWXTXH-RLJ2NC3-DMDFFNY-WEBJX42-LPLVMHX-TTZSFQX"; };
      };

      overrideFolders = true;
      folders = {
        "KeePass" = {
	  id = "ksh";
          path = "${homeDir}/data/Documents/KeePass";
          devices = [
            "AsM"
          ];
        };
      };
    };
  };
}
