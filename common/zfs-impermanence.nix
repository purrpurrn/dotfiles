{ config, pkgs, lib, inputs, ... }: {
  options.persistence.tmpfs.enable = lib.mkEnableOption "tmpfs";

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

      # ZFS Pool or tmpfs - root
      "/" = if (config.persistence.tmpfs.enable) then (
        {
          device = "tmpfs";
          fsType = "tmpfs";
          options = [
            "defaults"
            "size=2G"
            "mode=755"
          ];
        }
      ) else (
        {
          device = "zroot/enc/root";
          fsType = "zfs";
        }
      );

      # ZFS Pool - Nix Store
      "/nix" = {
        device = "zroot/enc/nix";
        fsType = "zfs";
	neededForBoot = true;
      };

      # ZFS Pool - `/tmp` — NixOS uses `/tmp` to build artifacts, I don't wanna allocate lots of RAM to temporarily store those.
      "/tmp" = {
        device = "zroot/enc/tmp";
        fsType = "zfs";
      };

      # ZFS Pool - Impermanence
      "/persist" = {
        device = "zroot/enc/persist";
        fsType = "zfs";
        neededForBoot = true;
      };
    };
  };
}
