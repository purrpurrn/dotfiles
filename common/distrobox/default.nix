{ pkgs, lib, config, ... }:
let
  distrobox = pkgs.callPackage ./distrobox-force-shell.nix {};
in
{
  options.virtualisation.distrobox.enable = lib.mkEnableOption "distrobox";

  config = lib.mkIf (config.virtualisation.distrobox.enable) {
    ##
    # Basic Install Stuff
    environment.systemPackages = [ pkgs.xorg.xhost distrobox ];
    virtualisation.podman.enable = true;
    virtualisation.podman.dockerCompat = true;
    environment.shellInit = ''
      [ -n "$DISPLAY" ] && xhost +si:localuser:$USER 2>&1 >/dev/null || true
    '';
  };
}
