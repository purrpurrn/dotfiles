{ config, pkgs, lib, ... }: {
  config = {
    programs.direnv = {
      enable = true;
      enableBashIntegration = true;
      enableNushellIntegration = true;
      enableZshIntegration = true;
    };
  };
}
