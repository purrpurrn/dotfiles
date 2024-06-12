{ config, pkgs, ... }: {
  config = {
    extraPlugins = [(pkgs.vimUtils.buildVimPlugin {
      name = "cmp-vimtex";
      src = pkgs.fetchFromGitHub {
        owner = "micangl";
        repo = "cmp-vimtex";
        rev = "a64b1b5eec0460144c91c4f20a45c74b8ded48ae";
        hash = "sha256-CO70M+l/9c4vqNm0XloOTzGQTmogHbSwvUFKQxYGsuw=";
    };})];

    plugins = {
      cmp-buffer = { enable = true; };
      cmp-nvim-lsp = { enable = true; };
      cmp-path = { enable = true; };
      cmp_luasnip = { enable = true; };
      cmp-fish = { enable = true; };

      cmp = {
        enable = true;
        autoEnableSources = false;
        settings = {
          experimental = {
	    ghost_text = true;
	  };

          sources = {
            __raw = ''
              cmp.config.sources({
                {name = 'nvim_lsp'},
                {name = 'path'},
                {name = 'luasnip'},
	        {name = 'fish'},
	        {name = 'vimtex'},
                }, {
              {name = 'buffer'},
              })
            '';
          };

	  mapping = {
            __raw = ''
              cmp.mapping.preset.insert({
	        -- Navigation
                ['<Tab>'] = cmp.mapping.select_next_item(),
                ['<S-Tab>'] = cmp.mapping.select_prev_item(),
                ['<C-ESC>'] = cmp.mapping.abort(),

                ['<C-Space>'] = cmp.mapping.complete(), -- Trigger CMP manually

                ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Insert Suggestion
                ['<R-CR>'] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }), -- Insert Suggestion & Replace
              })
            '';
          };
        };
      };
    };
  };
}
