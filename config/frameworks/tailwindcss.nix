{
  plugins.lsp.servers.tailwindcss = {
    enable = true;
    extraOptions.handlers = {
      "textDocument/hover".__raw = ''
        vim.lsp.with(vim.lsp.handlers.hover, {silent = true})
      '';
    };
  };
}
