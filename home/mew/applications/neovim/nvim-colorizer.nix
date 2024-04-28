{ config, pkgs, ... }: {
  config = {
    programs.nixvim.plugins.nvim-colorizer = {
      enable = true;
      userDefaultOptions.mode = "foreground";
    };
  };
}
