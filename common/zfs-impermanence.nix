{ config, pkgs, lib, inputs, ... }: {
  config = {
    boot = {
      supportedFilesystems = [ "zfs" ];
      kernelPackages = config.boot.zfs.package.latestCompatibleLinuxPackages;
      zfs = {
	forceImportRoot = false;
        package = pkgs.zfs_unstable;
        requestEncryptionCredentials = true;
      };
      initrd.postDeviceCommands = lib.mkAfter ''
        zfs rollback -r rpool/local/root@blank
      '';
    };

      services.zfs = {
        trim.enable = true;
        autoScrub.enable = true;
      };

      # Swap
      swapDevices = [{ device = "/dev/disk/by-label/SWAP"; }];
  
      # Generic ZFS impermanence filesystem layout
      fileSystems = {
        "/boot" = {
          device = "/dev/disk/by-label/NIXBOOT";
          fsType = "vfat";
        };

        # ZFS Datasets - Root
        "/" = {
          device = "zroot/root";
	  fsType = "zfs";
	  neededForBoot = true;
        };

        # ZFS Datasets - Nix Store
        "/nix" = {
          device = "zroot/nix";
  	  fsType = "zfs";
        };

        # ZFS Datasets - `/tmp` — NixOS uses `/tmp` to build artifacts, I don't wanna allocate lots of RAM to temporarily store those.
	"/tmp" = {
	  device = "zroot/tmp";
	  fsType = "zfs";
	};

        # ZFS Datasets - Impermanence
        "/persist" = {
          device = "zroot/persist";
          fsType = "zfs";
          neededForBoot = true;
        };
      };
    };
}
