{ config, pkgs, ... }: {
  config = {
    plugins.cmp = {
      enable = true;
      autoEnableSources = true;
    };
  };
}
