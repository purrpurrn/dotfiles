{ config, pkgs, lib, inputs, ... }: {
  config = {
    boot = {
      supportedFilesystems = [ "zfs" ];
      kernelPackages = config.boot.zfs.package.latestCompatibleLinuxPackages; # Latest Kernel supported by ZFS
      tmp.cleanOnBoot = true; # Clears `/tmp` on boot
      zfs = {
	forceImportRoot = false;
        package = pkgs.zfs_unstable;
        requestEncryptionCredentials = true;
      };
    };

    services.zfs = {
      trim.enable = true;
      autoScrub.enable = true;
    };

    # Swap
    swapDevices = [{ device = "/dev/disk/by-label/SWAP"; }];
  
    # Generic ZFS + tmpfs impermanence filesystem layout
    fileSystems = {
      "/boot" = {
        device = "/dev/disk/by-label/NIXBOOT";
        fsType = "vfat";
      };

      # tmpfs - root
      "/" = {
        device = "zroot/enc/root";
        fsType = "zfs";
      };

      # ZFS Datasets - Nix Store
      "/nix" = {
        device = "zroot/enc/nix";
        fsType = "zfs";
	neededForBoot = true;
      };

      # ZFS Datasets - `/tmp` — NixOS uses `/tmp` to build artifacts, I don't wanna allocate lots of RAM to temporarily store those.
      "/tmp" = {
        device = "zroot/enc/tmp";
        fsType = "zfs";
      };

      # ZFS Datasets - Impermanence
      "/persist" = {
        device = "zroot/enc/persist";
        fsType = "zfs";
        neededForBoot = true;
      };
    };
  };
}
