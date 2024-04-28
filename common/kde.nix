{ config, pkgs, inputs, lib, ... }: {
  options.services.kde.enable = lib.mkEnableOption "kde";

  config = lib.mkIf (config.services.kde.enable) {
    services.xserver.enable = lib.mkDefault true;
    services.xserver.displayManager.sddm.enable = lib.mkDefault true;
    services.xserver.desktopManager.plasma6.enable = lib.mkDefault true;
    services.xserver.desktopManager.plasma6.enableQt5Integration = lib.mkDefault true;
    services.power-profiles-daemon.enable = lib.mkDefault true;
  };
}
