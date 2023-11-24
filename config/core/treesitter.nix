{pkgs, ...}: {
  plugins.treesitter = {
    enable = true;
    indent = true;
    grammarPackages = pkgs.vimPlugins.nvim-treesitter.passthru.allGrammars;
  };

  plugins.treesitter-context.enable = true;
}
