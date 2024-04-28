{ self, lib, config, pkgs, ... }:
with lib;
let
  cfg = config.services.syncthing;
  optionalString = lib.optionalString;

  ##
  # From nixpkgs-module for syncthing.
  devices = mapAttrsToList (name: device: {
    deviceID = device.id;
    inherit (device) name addresses introducer;
  }) cfg.devices;

  folders = mapAttrsToList ( _: folder: {
    inherit (folder) path id label type;
    devices = map (device: { deviceId = cfg.devices.${device}.id; }) folder.devices;
    rescanIntervalS = folder.rescanInterval;
    fsWatcherEnabled = folder.watch;
    fsWatcherDelayS = folder.watchDelay;
    ignorePerms = folder.ignorePerms;
    ignoreDelete = folder.ignoreDelete;
    versioning = folder.versioning;
  }) (filterAttrs (
    _: folder:
    folder.enable
  ) cfg.folders);
in
{
  imports = [
    ./darwin.nix
    ./linux.nix
    ./settings.nix
  ];
  options = with lib; {
    services.syncthing = {
      reallyEnable = mkOption {
        type = types.bool;
        default = false;
      };

      initScript = mkOption {
        type = types.lines;
        default = ''
          if [ ! -d ${config.syncthing.configPath} ]; then
            mkdir -p ${config.syncthing.configPath}
          fi
          chmod 700 ${config.syncthing.configPath}
        '';
        internal = true;
      };

      configScript = mkOption {
        type = types.lines;
        internal = true;
      };

      configDir = mkOption {
        type = types.path;
        default = "${config.home.homeDirectory}/.config/Syncthing";
      };

      guiAddress = mkOption {
        type = types.str;
        default = "127.0.0.1:8384";
      };

      cert = mkOption {
        type = types.nullOr types.str;
        default = null;
        description = ''
          Path to users cert.pem file, will be copied into the syncthing's
          <literal>configDir</literal>
        '';
      };

      key = mkOption {
        type = types.nullOr types.str;
        default = null;
        description = ''
          Path to users key.pem file, will be copied into the syncthing's
          <literal>configDir</literal>
        '';
      };

      overrideDevices = mkOption {
        type = types.bool;
        default = true;
        description = ''
          Whether to delete the devices which are not configured via the
          <literal>declarative.devices</literal> option.
          If set to false, devices added via the webinterface will
          persist but will have to be deleted manually.
        '';
      };

      devices = mkOption {
        default = {};
        description = ''
          Peers/devices which syncthing should communicate with.
        '';
        example = {
          bigbox = {
            id = "7CFNTQM-IMTJBHJ-3UWRDIU-ZGQJFR6-VCXZ3NB-XUH3KZO-N52ITXR-LAIYUAU";
            addresses = [ "tcp://192.168.0.10:51820" ];
          };
        };
        type = types.attrsOf (types.submodule ({ name, ... }: {
          options = {

            name = mkOption {
              type = types.str;
              default = name;
              description = ''
                Name of the device
              '';
            };

            addresses = mkOption {
              type = types.listOf types.str;
              default = [];
              description = ''
                The addresses used to connect to the device.
                If this is let empty, dynamic configuration is attempted
              '';
            };

            id = mkOption {
              type = types.str;
              description = ''
                The id of the other peer, this is mandatory. It's documented at
                https://docs.syncthing.net/dev/device-ids.html
              '';
            };

            introducer = mkOption {
              type = types.bool;
              default = false;
              description = ''
                If the device should act as an introducer and be allowed
                to add folders on this computer.
              '';
            };

          };
        }));
      };

      overrideFolders = mkOption {
        type = types.bool;
        default = true;
        description = ''
          Whether to delete the folders which are not configured via the
          <literal>declarative.folders</literal> option.
          If set to false, folders added via the webinterface will persist
          but will have to be deleted manually.
        '';
      };

      folders = mkOption {
        default = {};
        description = ''
          folders which should be shared by syncthing.
        '';
        example = literalExpression ''
          {
            "/home/user/sync" = {
              id = "syncme";
              devices = [ "bigbox" ];
            };
          }
        '';
        type = types.attrsOf (types.submodule ({ name, ... }: {
          options = {

            enable = mkOption {
              type = types.bool;
              default = true;
              description = ''
                share this folder.
                This option is useful when you want to define all folders
                in one place, but not every machine should share all folders.
              '';
            };

            path = mkOption {
              type = types.str;
              default = name;
              description = ''
                The path to the folder which should be shared.
              '';
            };

            id = mkOption {
              type = types.str;
              default = name;
              description = ''
                The id of the folder. Must be the same on all devices.
              '';
            };

            label = mkOption {
              type = types.str;
              default = name;
              description = ''
                The label of the folder.
              '';
            };

            devices = mkOption {
              type = types.listOf types.str;
              default = [];
              description = ''
                The devices this folder should be shared with. Must be defined
                in the <literal>declarative.devices</literal> attribute.
              '';
            };

            versioning = mkOption {
              default = null;
              description = ''
                How to keep changed/deleted files with syncthing.
                There are 4 different types of versioning with different parameters.
                See https://docs.syncthing.net/users/versioning.html
              '';
              example = [
                {
                  versioning = {
                    type = "simple";
                    params.keep = "10";
                  };
                }
                {
                  versioning = {
                    type = "trashcan";
                    params.cleanoutDays = "1000";
                  };
                }
                {
                  versioning = {
                    type = "staggered";
                    params = {
                      cleanInterval = "3600";
                      maxAge = "31536000";
                      versionsPath = "/syncthing/backup";
                    };
                  };
                }
                {
                  versioning = {
                    type = "external";
                    params.versionsPath = pkgs.writers.writeBash "backup" ''
                      folderpath="$1"
                      filepath="$2"
                      rm -rf "$folderpath/$filepath"
                    '';
                  };
                }
              ];
              type = with types; nullOr (submodule {
                options = {
                  type = mkOption {
                    type = enum [ "external" "simple" "staggered" "trashcan" ];
                    description = ''
                      Type of versioning.
                      See https://docs.syncthing.net/users/versioning.html
                    '';
                  };
                  params = mkOption {
                    type = attrsOf (either str path);
                    description = ''
                      Parameters for versioning. Structure depends on versioning.type.
                      See https://docs.syncthing.net/users/versioning.html
                    '';
                  };
                };
              });
            };

            rescanInterval = mkOption {
              type = types.int;
              default = 3600;
              description = ''
                How often the folders should be rescaned for changes.
              '';
            };

            type = mkOption {
              type = types.enum [ "sendreceive" "sendonly" "receiveonly" ];
              default = "sendreceive";
              description = ''
                Whether to send only changes from this folder, only receive them
                or propagate both.
              '';
            };

            watch = mkOption {
              type = types.bool;
              default = true;
              description = ''
                Whether the folder should be watched for changes by inotify.
              '';
            };

            watchDelay = mkOption {
              type = types.int;
              default = 10;
              description = ''
                The delay after an inotify event is triggered.
              '';
            };

            ignorePerms = mkOption {
              type = types.bool;
              default = true;
              description = ''
                Whether to propagate permission changes.
              '';
            };

            ignoreDelete = mkOption {
              type = types.bool;
              default = false;
              description = ''
                Whether to delete files in destination. See <link
                xlink:href="https://docs.syncthing.net/advanced/folder-ignoredelete.html">
                upstream's docs</link>.
              '';
            };

          };
        }));
      };
    };
  };

  config = {
    services.syncthing.enable = lib.mkIf (pkgs.stdenv.isLinux) config.services.syncthing.reallyEnable;

    services.syncthing.initScript = toString (pkgs.writers.writeBash "merge-syncthing-config" ''
      set -efu
      # get the api key by parsing the config.xml
      while
          ! api_key=$(${pkgs.libxml2}/bin/xmllint \
              --xpath 'string(configuration/gui/apikey)' \
              ${cfg.configDir}/config.xml)
      do ${pkgs.coreutils}/bin/sleep 0; done
      curl() {
          ${pkgs.curl}/bin/curl -sS -H "X-API-Key: $api_key" \
              --retry 1000 --retry-delay 1 --retry-all-errors \
              "$@"
      }
      # query the old config
      old_cfg=$(curl ${cfg.guiAddress}/rest/config)
      # generate the new config by merging with the NixOS config options
      new_cfg=$(echo "$old_cfg" | ${pkgs.jq}/bin/jq -c '. * {
          "devices": (${builtins.toJSON devices}${optionalString (! cfg.overrideDevices) " + .devices"}),
          "folders": (${builtins.toJSON folders}${optionalString (! cfg.overrideFolders) " + .folders"})
      }')
      # send the new config
      curl -X PUT -d "$new_cfg" ${cfg.guiAddress}/rest/config
      # restart Syncthing if required
      if curl ${cfg.guiAddress}/rest/config/restart-required |
         ${pkgs.jq}/bin/jq -e .requiresRestart > /dev/null; then
          curl -X POST ${cfg.guiAddress}/rest/system/restart
      fi
    '');

    services.syncthing.configScript = lib.mkMerge [
      (''
        if [[ ! -d ${cfg.configDir} ]]; then
          ${pkgs.coreutils}/bin/mkdir -p ${cfg.configDir}
        fi
        ${pkgs.coreutils}/bin/chmod 700 ${cfg.configDir}
      '')

      (lib.mkIf (cfg.cert != null) ''
        ${pkgs.coreutils}/bin/cp ${cfg.cert} ${cfg.configDir}/cert.tmp
        ${pkgs.coreutils}/bin/chmod 400 ${cfg.configDir}/cert.tmp
        ${pkgs.coreutils}/bin/mv ${cfg.configDir}/cert.tmp ${cfg.configDir}/cert.pem
      '')
      
      (lib.mkIf (cfg.key != null) ''
        ${pkgs.coreutils}/bin/cp ${cfg.key} ${cfg.configDir}/key.tmp
        ${pkgs.coreutils}/bin/chmod 400 ${cfg.configDir}/key.tmp
        ${pkgs.coreutils}/bin/mv ${cfg.configDir}/key.tmp ${cfg.configDir}/key.pem
      '')
    ];

    services.syncthing.extraOptions = ["-home=${cfg.configDir}" "-gui-address=${cfg.guiAddress}"];
  };
}
