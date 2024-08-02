{ pkgs, ... }:
{
  plugins = {
    treesitter = {
      enable = true;
      settings.indent.enable = true;
      settings.highlight.enable = true;
      grammarPackages = pkgs.vimPlugins.nvim-treesitter.passthru.allGrammars;
    };

    treesitter-context.enable = true;
    treesitter-textobjects = {
      enable = true;
      select = {
        enable = true;
        keymaps = {
          "af" = "@function.outer";
          "if" = "@function.inner";
        };
      };
    };
  };
}
