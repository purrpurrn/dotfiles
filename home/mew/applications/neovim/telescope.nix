{ config, pkgs, inputs, ... }: {
  config = {
    programs.nixvim.extraPlugins = with pkgs.vimPlugins; [
      telescope-zoxide
    ];

    programs.nixvim.plugins.telescope = {
      enable = true;
      extensions.fzy-native.enable = true;
      extensions.frecency.enable = true;
      settings.defaults = {
        prompt_prefix = " ";
        selection_caret = " ";
      };
    };
    programs.nixvim.keymaps = [
      {
        key = "<leader>ff";
        action = "<cmd>Telescope find_files<cr>";
      }
      {
        key = "<leader>fg";
        action = "<cmd>Telescope live_grep<cr>";
      }
      {
        key = "<leader>fb";
        action = "<cmd>Telescope buffers<cr>";
      }
      {
        key = "<leader>fh";
        action = "<cmd>Telescope help_tags<cr>";
      }
    ];
  };
}
