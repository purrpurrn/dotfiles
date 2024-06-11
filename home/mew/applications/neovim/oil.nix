{ config, ... }: {
  config = {
    plugins.oil = {
      enable = true;
    };

    keymaps = [
      {
        key = "<leader>o";
	action = "<cmd>Oil<cr>";
      }
    ];
  };
}
