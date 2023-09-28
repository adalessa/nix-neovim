{
  imports = [ ./phpactor.nix ];

  plugins.fidget.enable = true;
  plugins.lsp = {
    enable = true;
    keymaps.diagnostic = {
      "<leader>vn" = "goto_next";
      "<leader>vp" = "goto_prev";
    };
    keymaps.lspBuf = {
      K = "hover";
      gD = "references";
      gd = "definition";
      gi = "implementation";
      gt = "type_definition";
      "<leader>vrn" = "rename";
      "<leader>vca" = "code_action";
    };

    onAttach = ''
      vim.keymap.set('n', '<leader>vf', function()
        vim.lsp.buf.format({async = true})
      end)
    '';
    servers = {
      nil_ls.enable = true;
      lua-ls.enable = true;
      gopls.enable = true;
      html.enable = true;
      jsonls.enable = true;
      rust-analyzer.enable = true;
      volar.enable = true;
      tsserver.enable = true;
    };
  };
}
