{ config, pkgs, ... }: {
  config = {
    plugins.lualine = {
      enable = true;
      iconsEnabled = true;
      theme = "base16";
      componentSeparators.left = "";
      componentSeparators.right = "";
      sectionSeparators.left = "";
      sectionSeparators.right = "";
      extensions = [
        "fzf"
	"oil"
	"trouble"
      ];
    };
  };
}
