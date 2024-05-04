{ config, pkgs, inputs, lib, ... }: {
  options.discord.vesktop.enable = lib.mkEnableOption "vesktop";

  config = lib.mkIf (config.discord.vesktop.enable) {
    home.packages = with pkgs; [
      (inputs.vesktop.legacyPackages."x86_64-linux".vesktop.overrideAttrs {
        desktopItems = [
          (makeDesktopItem {
            name = "Discord";
            desktopName = "Discord";
            exec = "${inputs.vesktop.legacyPackages."x86_64-linux".vesktop}/bin/vesktop --enable-features=VaapiIgnoreDriverChecks,VaapiVideoEncoder,VaapiVideoDecoder,CanvasOopRasterization,UseMultiPlaneFormatForHardwareVideo,UseOzonePlatform";
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
