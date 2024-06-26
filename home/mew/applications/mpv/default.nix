{ config, pkgs, lib, ... }: let
  homeDir = "${config.home.homeDirectory}";
in {
  options.app.mpv.enable = lib.mkEnableOption "mpv";
  options.app.mpv.ff2mpv.browsers.chromium.enable = lib.mkEnableOption "mpv.ff2mpv";
  
  config = lib.mkIf (config.app.mpv.enable) {
    # ff2mpv config
    home.packages = with pkgs; lib.mkIf (config.app.mpv.ff2mpv.browsers.chromium.enable) [
      ff2mpv-rust  
    ];

    # chromium variant
    programs.chromium.extensions = lib.mkIf (config.app.mpv.ff2mpv.browsers.chromium.enable) [
      "ephjcajbkgplkjmelpglennepbpmdpjg" # ff2mpv
    ];

    xdg.configFile."ff2mpv-chromium.json" = lib.mkIf (config.app.mpv.ff2mpv.browsers.chromium.enable) {
      enable = true;
      target = "chromium/NativeMessagingHosts/ff2mpv.json";
      text = ''
        {
          "name": "ff2mpv",
	  "description": "ff2mpv's external manifest",
	  "path": "${pkgs.ff2mpv-rust}/bin/ff2mpv-rust",
	  "type": "stdio",
	  "allowed_origins": [
	     "chrome-extension://ephjcajbkgplkjmelpglennepbpmdpjg/"
	  ]
	}
      '';
    }; 

    xdg.mimeApps = {
      enable = lib.mkDefault true;
      defaultApplications = {
        "x-scheme-handler/magnet" = [ "mpv.desktop" ];
        "image/*" = [ "mpv.desktop" ];
        "video/*" = [ "mpv.desktop" ];
        "audio/*" = [ "mpv.desktop" ];
      };
    };

    programs.mpv = {
      enable = true;
    
      bindings = {
        h = "script-binding memo-history";

        # uosc subtitles
        v = "script-message-to uosc subtitles";
        V = "cycle sub-visibility";

        c = "script-binding uosc/chapters"; # uosc chapter menu
        "/" = "script-binding uosc/menu"; # uosc main menu
        w = "script-binding uosc/stream-quality"; # uosc stream quality menu
        W = "script-binding seekto/toggle-seeker"; # Seek to XX:XX
        Q = "script-binding uosc/open-file"; # uosc file menu
        q = "script-binding uosc/playlist"; # uosc playlist menu
        M = "script-binding uosc/audio"; # uosc audio menu

        # Unbinds keys
        e = "ignore";
        ENTER = "cycle pause";

        # misc
        "Shift+ESC" = "quit";
        U = "cycle sub-ass-vsfilter-aspect-compat"; # toggle stretching SSA/ASS subtitles with anamorphic videos to match the historical rendere cycle deband
        T = "cycle ontop";
        t = "script-binding toggle-seeker"; # seek to XX:XX
        d = "cycle deband";
        D = "cycle deinterlace";
        "]" = "seek 90";
        "[" = "seek -90";
        "-" = "multiply speed 1/1.1"; # decrease the playback speed
        "=" = "multiply speed 1.1"; # increase the playback speed

        # playlist forward and prev
        "." = "playlist-next";
        "," = "playlist-prev";
        ">" = "frame-step";
        "<" = "frame-back-step";
      };
      defaultProfiles = [ "high-quality" ];
      config = {
        # General & OSD
        keep-open = true;
        save-position-on-quit = true;
        osd-bar = false;
        cursor-autohide = 700;
        osd-fractions = "";
        border = false;

        # Video
        vo = "gpu-next";
        hwdec = "vaapi";

        # Audio
        volume-max = 150;
        subs-with-matching-audio = false;

        # Screenshots
        screenshot-format = "png";
        screenshot-high-bit-depth = true;
        screenshot-png-compression = 6;
        screenshot-template = "%f-#%#00n";

        # Deband
        deband = false;
        deband-iterations = 4;
        deband-threshold = 48;
        deband-range = 16;
        deband-grain = 4;

        # Dither
        dither-depth = "auto";
        dither = "fruit";
        error-diffusion = "sierra-lite";

        # Anti-Ringing
        scale-antiring = 0.7;
        dscale-antiring = 0.7;
        cscale-antiring = 0.7;

        # Subtitles & Audio
        demuxer-mkv-subtitle-preroll = true;
        sub-auto = "fuzzy";
        screenshot-directory = "~/data/Pictures/screenshots";
        slang = [ 
          "de" 
          "deDE" 
	  "ger"
	  "deu"
	  "en"
	  "enEN"
	  "eng" 
        ];
        alang = [ 
          "de"
	  "deDE"
	  "ger"
	  "jp"
	  "jpn"
	  "jap"
	  "en"
	  "enEN"
	  "eng" 
        ];

        # Subtitle Styling
        sub-font = "Candara";
        sub-bold = true;
        sub-margin-y = 40;
        sub-border-size = 3.0;
        sub-border-color = "#0a0a0a";
        sub-font-size = 55;
      };

      scripts = with pkgs.mpvScripts; [
        uosc
        mpris
        seekTo
        mpv-webm
        autoload
        thumbfast
        webtorrent-mpv-hook
        #(pkgs.callPackage ./mpv-webtorrent-hook.nix { })
        blacklistExtensions
	memo
	evafast
        #(pkgs.callPackage ./mpv-webtorrent-hook.nix { inherit buildLua; })
      ];

      scriptOpts = {
        blacklist_extensions = {
          blacklist = "png, jpg, jpeg, heic";
          oneshot = true;
        };
        thumbfast = {
          max_height = 240;
  	  max_width = 240;
	  network = true;
        };
        webm = {
          keybind = "a";
	  output_directory = "~/data/Videos/mpv_clips";
	  output_format = "webm-vp9";
	  target_filesize = 25000;
	  crf = 30;
        };
        uosc = {
          progress = "never";
          scale = 1.3; # uosc ui scaling
	  proximity_in = 5;
	  proximity_out = 35;
	  autohide = true; # autohide uosc ui if mouse autohides.
	  disable_elements = "volume, pause_indicator, speed";
        };
        webtorrent = {
          path = "/tmp";
        };
      };

      profiles = {
        # Loops GIF & similar files
        "extension.gif" = {
          osc = false;
   	  save-position-on-quit = false;
	  no-resume-playback = "";
	  loop-file = "";
        };
        "extension.apng" = {
          profile = "extension.gif";
        };
        "extension.png" = {
          profile = "extension.gif";
        };
        "extension.jpg" = {
          profile = "extension.gif";
        };
        "extension.jpeg" = {
          profile = "extension.gif";
        };
        "extension.webp" = {
          profile = "extension.gif";
        };
        "extension.jxl" = {
          profile = "extension.gif";
        };
      
        "extension.opus" = {
          save-position-on-quit = false;
 	  no-resume-playback = "";
        };
        "extension.mp3" = {
          profile = "extension.opus";
        };
        "extension.m4a" = {
          profile = "extension.opus";
        };
        "extension.ogg" = {
          profile = "extension.opus";
        };
        "extension.oga" = {
          profile = "extension.opus";
        };
        "extension.flac" = {
          profile = "extension.opus";
        };
        "extension.wav" = {
          profile = "extension.opus";
        };
        "extension.aac" = {
          profile = "extension.opus";
        };
        "extension.mogg" = {
          profile = "extension.opus";
        };
        "extension.wma" = {
          profile = "extension.opus";
        };
      };
    };
  };
}
