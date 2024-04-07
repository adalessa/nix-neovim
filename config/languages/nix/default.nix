{
  plugins = {
    nix.enable = true;

    lsp.servers.nil_ls.enable = true;

    treesitter = {
      nixvimInjections = true;
    };

    none-ls = {
      enable = true;
      sources = {
        formatting.alejandra.enable = true;
        diagnostics.statix.enable = true;
        code_actions.statix.enable = true;
      };
    };
  };

  extraFiles = {
    "luasnippets/nix/nix.lua" = builtins.readFile ./snippets.lua;
  };

  files = {
    "ftplugin/nix.lua" = {
      opts = {
        tabstop = 2;
        softtabstop = 2;
        expandtab = true;
        shiftwidth = 2;
      };
    };
  };
}
