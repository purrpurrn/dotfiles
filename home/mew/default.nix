{ pkgs, config, inputs, ... }: {
  imports = [
    ./mail.nix
    ./directories.nix
    ./applications
  ];

  config = {

    app.git.enable = true;
    app.kitty.enable = true;
    app.ags.enable = true;
    app.btop.enable = true;
    app.direnv.enable = true;
    app.fish.enable = true;
    app.zoxide.enable = true;
#    app.hyperidle.enabled = true;
    app.discord.vesktop.enable = true;
#    app.hyprlock.enabled = false;
    app.streamlink.enable = true;
    app.chromium.enable = true;
    app.firefox.enable = true;
    app.mpv.enable = true;
    app.mpv.ff2mpv.browsers.chromium.enable = true;
    app.prism.enable = true;
    app.syncthing.enable = true;

    home = {
      username = "mew";
      homeDirectory = "/home/mew";
      stateVersion = "24.05";
    };

    home.packages = [
      inputs.hyprpicker.packages."${pkgs.system}".hyprpicker
      inputs.hyprcursor.packages."${pkgs.system}".hyprcursor
      inputs.self.packages."${pkgs.system}".mew.nvim
      (pkgs.prismlauncher.override { jdks = [ pkgs.temurin-bin-21 pkgs.temurin-bin-8 pkgs.temurin-bin-17 ]; withWaylandGLFW = true; })
      (pkgs.callPackage ../../common/pomo.nix { })
      pkgs.ncdu
      pkgs.unp
      pkgs.devenv
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
      pkgs.blender
      pkgs.steamguard-cli
      pkgs.fzy
      pkgs.rofi-wayland
      pkgs.obsidian
      pkgs.scrcpy
      pkgs.anki
      # Screen Recorders
      pkgs.gpu-screen-recorder
      pkgs.gpu-screen-recorder-gtk
      pkgs.obs-studio
      pkgs.ffmpeg-full # Video Editing
      # Drawing & Photo Editing
      pkgs.azpainter
      pkgs.krita
      # Process Managers - CLI
      pkgs.htop
      pkgs.killall
      # Process Managers - GUI
      pkgs.mission-center
      # Clipboard Managment
      pkgs.wl-clipboard
      pkgs.cliphist
      # External Drive Management
      pkgs.udiskie
      pkgs.bashmount
      # misc
      pkgs.texliveFull # LaTeX
      pkgs.brightnessctl # backlight management.
      pkgs.neofetch # system info.
      pkgs.yt-dlp # online video downloader.
      pkgs.keepassxc # Offline password manager with many features.
      pkgs.rsync # needed for copying
      # Fonts
      pkgs.helvetica-neue-lt-std
      pkgs.vistafonts
      pkgs.corefonts
      pkgs.google-fonts
      #pkgs.windows11-fonts
   ];

    # Allows fontconfig to detect fonts installed through `home.packages` and `nix-env`.
    fonts.fontconfig.enable = true;

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
	"application/x-apkg" = [ "anki.desktop" ];
	"application/x-anki" = [ "anki.desktop" ];
	"application/x-ankiaddon" = [ "anki.desktop" ];
      };
    };
  };
}
