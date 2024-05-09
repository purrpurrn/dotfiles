{ config, pkgs, lib, ... }: with lib; let
  cfg = config.programs.vesktop;
  jsonFormat = pkgs.formats.json { };
in {
  options.programs.vesktop = {
    enable = mkEnableOption "Discord Custom Client with better Screen Sharing";

    package = mkOption {
      type = types.package;
      default = pkgs.vesktop;
      defaultText = literalExpression "pkgs.vesktop";
      description = ''
        Vesktop package to install.
      '';
    };

    settings = mkOption {
      type = jsonFormat.type;
      default = null;
    };

    quickCSS = mkOption {
      type = lib.types.nullOr (lib.types.either lib.types.path lib.types.lines);
      default = null;
    };
  };

  config = {
    xdg.configFile."vesktop/settings/setting.json".source = jsonFormat.generate "setting.json" cfg.settings;

    xdg.configFile."vesktop/settings.json".source = jsonFormat.generate "settings.json" cfg.settings;

    xdg.configFile = {
      "vesktop/settings/quickCss.css".text = '' ${cfg.quickCSS} '';
    };
  };
}
