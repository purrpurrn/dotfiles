{ config, pkgs, inputs, ... }: {
  config = {
    programs.nixvim.plugins.oil = {
      enable = true;
    };
    programs.nixvim.keymaps = [
      {
        key = "<leader>o";
	action = "<cmd>Oil<cr>";
      }
    ];
  };
}
