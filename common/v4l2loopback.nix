{ config, pkgs, inputs, lib, ... }: {
#  options.services.v4l2loopback = {
#    enable = lib.mkEnableOption (lib.mdDoc "v4l2loopback wrapper");
#
#    devices = mkOption {
#      
#    };
#  };

  config = {
    # Make some extra kernel modules available to NixOS
    boot.extraModulePackages = [ 
      config.boot.kernelPackages.v4l2loopback.out 
    ];

    boot.kernelModules = [
      "v4l2loopback"
    ];

    boot.extraModprobeConfig = ''
      # exclusive_caps: Skype, Zoom, Teams etc. will only show device when actually streaming
      # card_label: Name of virtual camera, how it'll show up in Skype, Zoom, Teams
      # https://github.com/umlaeute/v4l2loopback
      options v4l2loopback exclusive_caps=1 card_label="Logitech" video_nr=9
    '';
  };
}
