{
  plugins.lsp.servers.gopls.enable = true;

  autoCmd = [
    {
      event = ["FileType"];
      pattern = ["go"];
      callback = {
        __raw = ''
          function()
            vim.bo.makeprg = "go build"

            vim.opt.listchars:append({tab="> "})

            vim.bo.expandtab = false
            vim.bo.tabstop = 4
            vim.bo.softtabstop = 4
            vim.bo.shiftwidth = 4
          end
        '';
      };
    }
  ];
}
