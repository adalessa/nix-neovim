{lib, ...}: {
  plugins = {
    nix.enable = true;

    lsp.servers.nil-ls.enable = true;

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
    "luasnippets/nix/nix.lua".source = ./snippets.lua;
    "queries/nix/injections.scm".enable = true;
    "queries/nix/injections.scm".source = lib.mkForce ./injections.scm;
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
