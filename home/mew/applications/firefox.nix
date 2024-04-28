{ config, pkgs, inputs, ... }: {
  imports = [ inputs.schizofox.homeManagerModule ];

  config = {
    programs.schizofox = {
      enable = true;
    };
  };
}
