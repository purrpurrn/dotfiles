{ config, pkgs, ... }: {
  config = {
    plugins.vimtex = {
      enable = true;
      texlivePackage = pkgs.texliveFull;
    };
  };
}
