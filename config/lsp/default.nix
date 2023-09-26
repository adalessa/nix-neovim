{ pkgs, ... }: {
  imports = [
    ./phpactor.nix
  ];

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
    };

    onAttach = ''
      vim.keymap.set('n', '<leader>vf', function()
        vim.lsp.buf.format({async = true})
      end)
    '';
    servers = {
      rnix-lsp.enable = true;
      lua-ls.enable = true;
    };
  };
}
