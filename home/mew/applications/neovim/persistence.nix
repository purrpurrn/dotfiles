{ config, ... }: {
  config = {
    plugins.persistence = {
      enable = true;
    };

    keymaps = [
      {
        key = "<leader>s";
        action = "<cmd>lua require('persistence').load()<cr>";
      }
    ];
  };
}
