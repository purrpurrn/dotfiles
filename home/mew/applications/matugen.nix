{ config, pkgs, inputs, ... }: {
  imports = [
    inputs.matugen.homeManagerModules.default
  ];

  config = {
    programs.matugen = {
      enable = true;
      wallpaper = ./prism/wallpapers/4.jpg;
    };
  };
}
