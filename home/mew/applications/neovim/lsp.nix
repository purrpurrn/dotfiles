{ config, ... }: {
  config = {
    plugins.lsp = {
      enable = true;
      servers = {
        tsserver.enable = true; # javascript & typescript
	lua-ls.enable = true; # lua
	jsonls.enable = true; # json
	cssls.enable = true; # css
	html.enable = true; # html
	bashls.enable = true; # bash
        nil_ls.enable = true; # nix programming language
      };
    };
  };
}
