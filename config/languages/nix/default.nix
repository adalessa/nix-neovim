{helpers, ...}: {
  plugins = {
    nix.enable = true;

    lsp.servers.nil_ls.enable = true;

    none-ls = {
      enable = true;
      sources = {formatting.alejandra.enable = true;};
    };
  };

  extraFiles = {
    "luasnippets/nix/nix.lua" = builtins.readFile ./snippets.lua;
  };

  autoCmd = [
    {
      event = ["FileType"];
      pattern = ["nix"];
      callback = helpers.mkRaw ''
        function()
          local set = vim.bo

          set.tabstop = 2
          set.softtabstop = 2
          set.expandtab = true
          set.shiftwidth = 2
        end
      '';
    }
  ];
}
