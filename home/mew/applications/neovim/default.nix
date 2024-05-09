{ config, pkgs, inputs, lib, ... }: {
  imports = [
    inputs.nixvim.homeManagerModules.nixvim
    ./noice.nix
    ./cmp.nix
    ./oil.nix
    ./telescope.nix
    ./nvim-colorizer.nix
    ./lualine.nix
  ];

  options.app.neovim.enable = lib.mkEnableOption "neovim";

  config = lib.mkIf (config.app.neovim.enable) {
    programs.nixvim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
      enableMan = true;
      globals = {
        mapleader = " ";
      };
      colorschemes = {
        base16 = {
	  enable = true;
	  colorscheme = {
	    base00 = "#${config.colorScheme.palette.base00}";
	    base01 = "#${config.colorScheme.palette.base01}";
	    base02 = "#${config.colorScheme.palette.base02}";
	    base03 = "#${config.colorScheme.palette.base03}";
	    base04 = "#${config.colorScheme.palette.base04}";
	    base05 = "#${config.colorScheme.palette.base05}";
	    base06 = "#${config.colorScheme.palette.base06}";
	    base07 = "#${config.colorScheme.palette.base07}";
	    base08 = "#${config.colorScheme.palette.base08}";
	    base09 = "#${config.colorScheme.palette.base09}";
	    base0A = "#${config.colorScheme.palette.base0A}";
	    base0B = "#${config.colorScheme.palette.base0B}";
	    base0C = "#${config.colorScheme.palette.base0C}";
	    base0D = "#${config.colorScheme.palette.base0D}";
	    base0E = "#${config.colorScheme.palette.base0E}";
	    base0F = "#${config.colorScheme.palette.base0F}";
	  };
	};
        rose-pine = {
	  enable = true;
          transparentBackground = true;
	};
      };
      options = {
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
	lsp = {
          enable = true;
	  servers = {
            tsserver.enable = true; # javascript & typescript
	    nil_ls.enable = true; # nix programming language
	  };
	};
      };
      extraPlugins = with pkgs.vimPlugins; [
        nvim-web-devicons
	twilight-nvim
	neoscroll-nvim
      ];
    };
  };
}
