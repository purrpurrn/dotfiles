{ config, pkgs, inputs, ... }: {
  config = {
    extraPlugins = with pkgs.vimPlugins; [
      telescope-zoxide
    ];

    plugins.telescope = {
      enable = true;
      extensions.fzy-native.enable = true;
      extensions.frecency.enable = true;
      settings.defaults = {
        prompt_prefix = " ";
        selection_caret = " ";
      };
    };

    keymaps = [
      {
        key = "<leader>f";
        action = "<cmd>Telescope find_files<cr>";
      }
      {
        key = "<leader>g";
        action = "<cmd>Telescope live_grep<cr>";
      }
      {
        key = "<leader>b";
        action = "<cmd>Telescope buffers<cr>";
      }
      {
        key = "<leader>h";
        action = "<cmd>Telescope help_tags<cr>";
      }
      {
        key = "<leader>r";
	action = "<cmd>Telescope oldfiles<cr>";
      }
    ];
  };
}
