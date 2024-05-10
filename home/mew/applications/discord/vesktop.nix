{ config, pkgs, lib, ... }: {
  options.app.discord.vesktop.enable = lib.mkEnableOption "vesktop";

  config = lib.mkIf (config.app.discord.vesktop.enable) {
    home.packages = with pkgs; [
      (pkgs.vesktop.overrideAttrs {
        desktopItems = [
          (makeDesktopItem {
            name = "Discord";
            desktopName = "Discord";
            exec = "${pkgs.vesktop}/bin/vesktop --enable-features=VaapiIgnoreDriverChecks,VaapiVideoEncoder,VaapiVideoDecoder,CanvasOopRasterization,UseMultiPlaneFormatForHardwareVideo,UseOzonePlatform,ozone-platform=wayland";
            icon = "discord";
            genericName = "${pkgs.discord.meta.description}";
            keywords = ["discord" "vencord" "electron" "chat"];
            categories = ["Network" "InstantMessaging" "Chat"];
          })
        ];
      })
    ];
  };
}
