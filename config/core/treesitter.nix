{pkgs, ...}: {
  plugins = {
    treesitter = {
      enable = true;
      indent = true;
      grammarPackages = pkgs.vimPlugins.nvim-treesitter.passthru.allGrammars;
    };

    treesitter-context.enable = true;
  };
}
