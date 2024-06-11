{ config, pkgs, lib, ... }: {
  imports = [
    ./cmp.nix
    ./oil.nix
    ./lsp.nix
    ./lualine.nix
    ./telescope.nix
    ./persistence.nix
    ./nvim-colorizer.nix
  ];

  config = {
    colorschemes.base16 = {
      enable = true;
      colorscheme = "rose-pine";
    };

    globals = {
      mapleader = " ";
    };

    opts = {
      number = true;
      relativenumber = true;
      clipboard = "unnamedplus";
      undofile = true;
      termguicolors = true;
      signcolumn = "no";
    };

    plugins = {
      cursorline.cursorword.enable = true;
      treesitter.enable = true;
      trouble.enable = true;
      luasnip.enable = true;
      image.enable = true;
      noice.enable = lib.mkForce false;
      vimtex.enable = true;
    };

    extraPlugins = with pkgs.vimPlugins; [
      nvim-web-devicons
      twilight-nvim
      neoscroll-nvim
    ];
  };
}
