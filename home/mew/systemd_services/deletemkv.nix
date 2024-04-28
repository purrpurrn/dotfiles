{ config, pkgs, ... }: let 
  homeDir = "${config.home.homeDirectory}";
  webtorrentDir = "${config.home.homeDirectory}/data/Videos/webtorrent";
in {
  systemd.user.services.deletemkv = {
    Unit = {
      Description = "deletes all *.mkv files in the ${webtorrentDir} directory";
    };

    Service = {
      ExecStart = "${pkgs.bash}/bin/bash -c '${pkgs.fd}/bin/fd . --type f --maxdepth 1 -x ${pkgs.coreutils}/bin/rm {} \\; ${webtorrentDir}'";
    };

    Install = {
      WantedBy = "default.target";
    };
  };
}
