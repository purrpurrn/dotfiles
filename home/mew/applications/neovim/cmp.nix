{ config, pkgs, ... }: {
  config = {
    programs.nixvim.plugins.cmp = {
      enable = true;
      autoEnableSources = true;
    };
  };
}
