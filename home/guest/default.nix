{ pkgs, config, inputs, ... }: {
  config = {
    # Allows fontconfig to detect fonts installed through `home.packages` and `nix-env`.
    fonts.fontconfig.enable = true;

    home = {
      username = "Guest";
      homeDirectory = "/home/guest";
      stateVersion = "23.05";
      
      packages = [
	pkgs.gpu-screen-recorder
	pkgs.gpu-screen-recorder-gtk
        pkgs.ffmpeg-full
        pkgs.jq
        pkgs.fd
        pkgs.ripgrep
	pkgs.tree
	pkgs.p7zip
	pkgs.unar
	pkgs.pciutils
	pkgs.libnotify
        pkgs.heroic
        pkgs.swaybg
        pkgs.ff2mpv
        pkgs.blender
        pkgs.wl-clipboard
	pkgs.pulseaudio
	pkgs.krita
	pkgs.kitty
	pkgs.steamguard-cli
	pkgs.fzy
	pkgs.rofi-wayland
	pkgs.obsidian
	pkgs.scrcpy
	pkgs.anki
	pkgs.azpainter
	# Process Managers - CLI
	pkgs.htop
	pkgs.btop
	pkgs.killall
	# Process Managers - GUI
	pkgs.mission-center
	# Fonts
        pkgs.helvetica-neue-lt-std
        pkgs.vistafonts
	pkgs.corefonts
	pkgs.google-fonts
	# misc
	pkgs.yt-dlp # misc - online video downloader.
      ];
    };

    xdg.userDirs = {
      enable = true;
      pictures = "$HOME/Pictures";
      videos = "$HOME/Videos";
      extraConfig = {
        XDG_SCREENSHOTS_DIR = "$HOME/Pictures/screenshots";
	XDG_CONFIG_HOME = "$HOME/.config";
      };
    };

    xdg.mimeApps = {
      enable = true;
      defaultApplications = {
        "text/plain" = [ "nvim.desktop" ];
	"text/markdown" = [ "nvim.desktop" ];
	"application/pdf" = [ "chromium-browser.desktop" ];
	"image/*" = [ "mpv.desktop" ];
	"video/*" = [ "mpv.desktop" ];
	"audio/*" = [ "mpv.desktop" ];
	"application/x-apkg" = [ "anki.desktop" ];
	"application/x-anki" = [ "anki.desktop" ];
	"application/x-ankiaddon" = [ "anki.desktop" ];
	"x-scheme-handler/magnet" = [ "mpv.desktop" ];
      };
    };
  };
}
