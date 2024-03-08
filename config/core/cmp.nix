{
  plugins = {
    cmp-buffer.enable = true;
    cmp-path.enable = true;
    cmp-nvim-lsp.enable = true;
    cmp_luasnip.enable = true;
    cmp-cmdline.enable = true;
    cmp-git.enable = true;
    lspkind = {
      enable = true;
      cmp.enable = true;
      cmp.menu = {
        buffer = "[buf]";
        nvim_lsp = "[ ]";
        nvim_lua = "[api]";
        path = "[path]";
        luasnip = "[snip]";
        "vim-dadbod-completion" = "[DB]";
      };
    };
    cmp = {
      enable = true;
      settings = {
        snippet.expand = ''
          function(args)
            require('luasnip').lsp_expand(args.body)
          end
        '';
        mapping = {
          "<c-y>" = "cmp.mapping.confirm({ select = true, behavior = cmp.ConfirmBehavior.Insert })";
          "<c-d>" = "cmp.mapping.scroll_docs(-4)";
          "<c-f>" = "cmp.mapping.scroll_docs(4)";
          "<c-space>" = "cmp.mapping.complete()";
          "<c-e>" = "cmp.mapping.abort()";
          "<c-n>" = "cmp.mapping.select_next_item()";
          "<c-p>" = "cmp.mapping.select_prev_item()";
        };
        sources = [
          {name = "nvim_lsp";}
          {name = "path";}
          {name = "buffer";}
          {name = "luasnip";}
        ];
      };
      filetype = {
        gitcommit = {
          sources = [
            {name = "cmp_git";}
            {name = "buffer";}
          ];
        };
        sql = {
          sources = [
            {name = "vim-dadbod-completion";}
            {name = "buffer";}
          ];
        };
      };
      cmdline = {
        "/" = {
          mapping = {
            __raw = "cmp.mapping.preset.cmdline()";
          };
          sources = [
            {name = "buffer";}
          ];
        };
        "?" = {
          mapping = {
            __raw = "cmp.mapping.preset.cmdline()";
          };
          sources = [
            {name = "buffer";}
          ];
        };
        ":" = {
          mapping = {
            __raw = "cmp.mapping.preset.cmdline()";
          };
          sources = [
            {name = "path";}
            {name = "cmdline";}
          ];
        };
      };
    };
  };
}
