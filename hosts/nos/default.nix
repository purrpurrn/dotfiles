{ config, pkgs, inputs, lib, ...}: {
  imports = [
    ./persistence.nix
    ../../common/zfs-impermanence.nix
    ../../common/steam.nix
    ../../common/VM.nix
    ../../common/1password.nix
    ../../common/polkit.nix
    ../../common/gtk.nix
    ../../common/hyprland.nix
    ../../common/kdeconnect.nix
    ../../common/v4l2loopback.nix
    inputs.flake-programs-sqlite.nixosModules.programs-sqlite # command-not-found workaround
  ];
   config = {
     virtualisation.waydroid.enable = true;

     # Networking
     networking.hostName = "nos";
     networking.networkmanager.enable = true;

     security.polkit.enable = true;
     
     services.gvfs.enable = true; # USB Automounting

     environment.systemPackages = [ 
       pkgs.mate.mate-polkit
     ];
     services.onepassword.enable = true;

     # Internationalisation properties
     time.timeZone = "Europe/Berlin";
     i18n.defaultLocale = "en_DK.UTF-8";
 
     services.printing.enable = true; # enables printing
 
     system.stateVersion = "23.05";
     nix.settings.experimental-features = [ "nix-command" "flakes" ]; # enables flakes

     # Allows Unfree/Proprietary packages
     nixpkgs.config.allowUnfree = true;
     nixpkgs.config.allowUnfreePredicate = (_: true);
     environment.sessionVariables = { NIXPKGS_ALLOW_UNFREE = "1"; };
  };
}
