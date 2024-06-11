{ config, pkgs, ... }: {
  config = {
    plugins.nvim-colorizer = {
      enable = true;
      userDefaultOptions.mode = "foreground";
    };
  };
}
