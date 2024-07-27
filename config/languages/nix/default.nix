{
  plugins = {
    nix.enable = true;

    lsp.servers.nil-ls.enable = true;

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
