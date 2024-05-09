{ pkgs, config, inputs, ... }: {
  imports = [
    ./gtk.nix
    ./mail.nix
    ./base16.nix
    ./directories.nix
    ./applications
  ];

  config = {
    # Allows fontconfig to detect fonts installed through `home.packages` and `nix-env`.
    fonts.fontconfig.enable = true;

    app.neovim.enable = true;
    app.git.enable = true;
    app.kitty.enable = true;
    app.ags.enable = true;
    app.btop.enable = true;
    app.direnv.enable = true;
    app.fish.enable = true;
#    app.hyperidle.enable = true;
    app.discord.vesktop.enable = true;
    app.hyprlock.enable = true;
    app.obs.enable = true;
    app.streamlink.enable = true;
    app.chromium.enable = true;
    app.mpv.enable = true;
    app.prism.enable = true;
    app.syncthing.enable = true;

    home = {
      username = "mew";
      homeDirectory = "/home/mew";
      stateVersion = "23.05";
      sessionVariables = {
        EDITOR = "nvim";
      };
      
      packages = [
        inputs.hyprpicker.packages."x86_64-linux".hyprpicker
	inputs.hyprcursor.packages."x86_64-linux".hyprcursor
	(pkgs.prismlauncher.override { jdks = [ pkgs.temurin-bin-21 pkgs.temurin-bin-8 pkgs.temurin-bin-17 ]; withWaylandGLFW = true; })
	(pkgs.callPackage ../../common/pomo.nix {})
	pkgs.ncdu
        pkgs.unp
	pkgs.gpu-screen-recorder
	pkgs.gpu-screen-recorder-gtk
	pkgs.devenv
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
	pkgs.killall
	# Process Managers - GUI
	pkgs.mission-center
	# Fonts
	pkgs.nerdfonts
        pkgs.helvetica-neue-lt-std
        pkgs.vistafonts
	pkgs.corefonts
	pkgs.google-fonts
	# misc
	pkgs.brightnessctl # misc - backlight management.
	pkgs.neofetch # misc - system info.
	pkgs.yt-dlp # misc - online video downloader.
	pkgs.keepassxc # misc - Offline password manager with many features.
      ];
    };

    xdg.userDirs = {
      enable = true;
      pictures = "$HOME/data/Pictures";
      videos = "$HOME/data/Videos";
      extraConfig = {
        XDG_SCREENSHOTS_DIR = "$HOME/data/Pictures/screenshots";
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
