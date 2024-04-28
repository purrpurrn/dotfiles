{ lib, config, pkgs, ... }:
let
  cfg = config.services.syncthing;
in
{
  config = lib.mkIf (pkgs.stdenv.isLinux) {
    systemd.user.services = lib.mkIf (cfg.enable) {
      syncthing = {
        Service = {
          ExecStartPre = "${pkgs.writeScript "config-dir" ''
            #!${pkgs.stdenv.shell}
            ${cfg.configScript}
          ''}";
        };
      };
      syncthing-init = lib.mkIf (
        cfg.devices != {} || cfg.folders != {} || cfg.extraOptions != {}
      ) {
        Unit = {
          Description = "Syncthing configuration updater";
          Requisite = [ "syncthing.service" ];
          After = [ "syncthing.service" ];
        };
        Install = {
          WantedBy = [ "default.target" ];
        };
        Service = {
          RemainAfterExit = true;
          Type = "oneshot";
          ExecStart = cfg.initScript;
        };
      };
    };
  };
}
