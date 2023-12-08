{
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
    };

    onAttach = ''
      vim.keymap.set('n', '<leader>vf', function()
        vim.lsp.buf.format({async = true})
      end)

      vim.keymap.set('i', '<c-t>', function()
        vim.lsp.buf.signature_help()
      end)

      vim.keymap.set({'v', 'n'}, '<leader>vca', vim.lsp.buf.code_action)
    '';
  };
}
