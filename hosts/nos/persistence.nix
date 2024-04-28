{ inputs, impermanence, config, ... }:
{
  imports = [ inputs.impermanence.nixosModule ];

  config = {
    users.mutableUsers = false;

    environment.persistence."/nix/persist" = {
      hideMounts = true; # hides whitelisted directories and files from commmands like "lsblk".
      directories = [
        "/etc/nixos"
	"/etc/NetworkManager/system-connections"
	"/var/lib/waydroid"
      ];
      files = [
        "/etc/machine-id"
      ];
      users.mew = {
        directories = [
          ".config/hypr"
          ".config/ags"
	  ".config/chromium"
	  ".config/1Password"
	  ".config/steamguard-cli"
	  ".config/tofi/"
	  ".config/obsidian"
	  ".config/sops/age"
	  ".config/heroic"
	  ".config/discordWebConfig"
	  ".config/YTMusicWebConfig"
	  ".1password"
	  ".ssh"
	  ".local/share/PrismLauncher"
	  ".local/share/Steam"
	  ".local/share/Anki2"
	  ".local/state/mpv/watch_later"
	  ".local/share/icons"
	  ".icons"
	  "data/Pictures/memes"
	  "data/Pictures/screenshots"
	  "data/Pictures/other"
	  "data/music"
	  "data/recordings"
	  "data/Games/OMORI"
	  "data/Games/The Song of Saya"
	  "data/Games/Heroic"
	  "data/Documents"
	  "data/Documents/cooklang"
	  "data/Videos/Replays"
	  "data/Videos/Captures"
	  "data/Videos/mpv_clips"
	  "data/Videos/webtorrent"
	];
	files = [
          ".config/mpv/memo-history.log"
	  ".config/gpu-screen-recorder/config"
#	  ".config/sops/age/keys.txt"
	];
      };
    };
  };
}
