{ self, pkgs, lib, ... }:
{
  imports = [
   ./prism
   ./neovim
   ./discord
   ./YT_Music
   ./syncthing
   ./ags.nix
   ./zsh.nix
   ./git.nix
   ./mpv.nix
   ./btop.nix
   ./fish.nix
   ./niri.nix
   ./kitty.nix
   ./direnv.nix
   ./zoxide.nix
   ./firefox.nix
   ./default.nix
   ./nushell.nix
   ./chromium.nix
   ./streamlink.nix
   ./easyeffects.nix
   ./wl-screenshot.nix
  ];
}
