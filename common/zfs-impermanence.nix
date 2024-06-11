{ config, pkgs, lib, inputs, ... }: {
  options.persistence.tmpfs.enable = lib.mkEnableOption "tmpfs";
  options.boot.kernel.xanmod.enable = lib.mkEnableOption "xanmod";

  config = {
    boot = {
      supportedFilesystems = [ "zfs" ];
      kernelPackages = if (config.boot.kernel.xanmod.enable) then pkgs.linuxPackages_xanmod else config.boot.zfs.package.latestCompatibleLinuxPackages; # Xanmod or latest linux kernel with zfs support
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
	options = [ "umask=0077" ]; # semi-secures `/boot` from being world accessible. source: https://github.com/NixOS/nixpkgs/issues/279362#issuecomment-1913126484 & https://github.com/NixOS/nixpkgs/issues/279362#issuecomment-1913506090
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
