{config, lib, pkgs, inputs, ...}: {
  imports = [
    "${inputs.hardware}/common/cpu/amd"
    "${inputs.hardware}/common/gpu/amd"
    "${inputs.hardware}/common/pc/ssd"
    "${inputs.hardware}/common/pc/laptop"
    ./bootloader.nix
  ];

  boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "usbhid" "usb_storage" "sd_mod" ];
  boot.kernelModules = [ "kvm-amd" "ddcci-driver-linux" ];

  # Audio
  boot.extraModprobeConfig = ''
    options snd-hda-intel patch=hda-jack-retask.fw
  ''; 
  hardware.firmware = let
    rtl_alc236 = pkgs: pkgs.runCommand "rtl_alc236" {} ''
      mkdir -p $out/lib/firmware
      cp ${./hda-jack-retask.fw} $out/lib/firmware/hda-jack-retask.fw
    '';
  in [
    (rtl_alc236 pkgs)
    pkgs.rtw88-firmware
  ];

  networking.hostId = "8425e349";

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";

  systemd.services.NetworkManager-wait-online.enable = false; # reduces boot time

  # Some applications error out if vulkan-loader is not installed e.g vulkaninfo
  hardware.opengl.extraPackages = [
    pkgs.vulkan-loader
    pkgs.vulkan-validation-layers
    pkgs.vulkan-extension-layer
  ];
}
