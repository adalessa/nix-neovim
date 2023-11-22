{
  imports = [./phpactor.nix ./lua-ls.nix ./htmx.nix];

  plugins.fidget.enable = true;
  plugins.lsp = {
    enable = true;
    keymaps.lspBuf = {
      K = "hover";
      gD = "references";
      gd = "definition";
      gi = "implementation";
      gT = "type_definition";
      "<leader>vrn" = "rename";
      "<leader>vca" = "code_action";
    };

    onAttach = ''
      vim.keymap.set('n', '<leader>vf', function()
        vim.lsp.buf.format({async = true})
      end)

      vim.keymap.set('i', '<c-y>', function()
        vim.lsp.buf.signature_help()
      end)
    '';

    servers = {
      nil_ls.enable = true;
      gopls.enable = true;
      html.enable = true;
      jsonls.enable = true;
      rust-analyzer.enable = true;
      volar.enable = true;
      tsserver.enable = true;
      tailwindcss = {
        enable = true;
        extraOptions.handlers = {
          "textDocument/hover".__raw = ''
            vim.lsp.with(vim.lsp.handlers.hover, {silent = true})
          '';
        };
      };
    };
  };
}
