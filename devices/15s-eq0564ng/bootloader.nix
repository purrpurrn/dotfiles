{ config, pkgs, inputs, ... }: {
  config = {
    # Bootloader
    boot.loader.systemd-boot.enable = true;
    boot.loader.systemd-boot.editor = false; # set to false out of security reasons
    boot.loader.timeout = 2;
    boot.loader.efi.canTouchEfiVariables = true; # Installation process is allowed to modify EFI boot variables.

    boot.binfmt.emulatedSystems = [ "aarch64-linux" ]; # arm64 emulation
  };
}
