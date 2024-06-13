{ self, pkgs, lib, ... }: {
  imports = [
   ./mpv
   ./discord
   ./YT_Music
   ./syncthing
   ./ags.nix
   ./zsh.nix
   ./git.nix
   ./btop.nix
   ./fish.nix
   ./niri.nix
#   ./aagl.nix
   ./kitty.nix
   ./direnv.nix
   ./zoxide.nix
   ./stylix.nix
   ./firefox.nix
   ./nushell.nix
   ./chromium.nix
   ./streamlink.nix
   ./easyeffects.nix
   ./wl-screenshot.nix
  ];
}
