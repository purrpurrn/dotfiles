{ lib, pkgs, config
, ... }:
let
  cfg = config.services.syncthing;
in
{
  config = lib.mkIf (pkgs.stdenv.isDarwin && cfg.reallyEnable) {
    launchd.agents.syncthing = {
      enable = true;
      config = {
        ProgramArguments =
          let
            script = toString (pkgs.writeShellScript "syncthing-start" ''
              ${cfg.configScript}
              ${pkgs.syncthing}/bin/syncthing -no-browser -home=${cfg.configDir} -gui-address=${cfg.guiAddress} &
              ${cfg.initScript}
              wait
            '');
          in
          [ script ];
        KeepAlive = true;
      };
    };
  };
}
