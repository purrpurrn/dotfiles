{ config, pkgs, lib, ... }: {
  options.git.enable = lib.mkEnableOption "git";
  
  config = lib.mkIf (config.git.enable) {
    programs.git = {
      enable = true;
      userName = "purrpurrn";
      userEmail = "scrcpynovideoaudiocodecraw+hdmzwl@gmail.com";
      extraConfig = {
        gpg."ssh".program = "${pkgs._1password-gui}/bin/op-ssh-sign";
	core.editor = "nvim";
      };
    };
  };
}
