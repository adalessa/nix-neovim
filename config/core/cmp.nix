{
  plugins = {
    cmp-buffer.enable = true;
    cmp-path.enable = true;
    cmp-nvim-lsp.enable = true;
    cmp_luasnip.enable = true;
    cmp-cmdline.enable = true;
    cmp-git.enable = true;
    # temporary disable copilot since i lost the license
    # copilot-cmp.enable = true;
    # copilot-lua = {
    #   enable = true;
    #   panel.enabled = false;
    #   suggestion.enabled = false;
    # };
    lspkind = {
      enable = true;
      cmp.enable = true;
      cmp.menu = {
        buffer = "[buf]";
        nvim_lsp = "[ ]";
        nvim_lua = "[api]";
        path = "[path]";
        luasnip = "[snip]";
        # copilot = "[ﮧ]";
        "vim-dadbod-completion" = "[DB]";
      };
    };
    nvim-cmp = {
      enable = true;
      snippet.expand = "luasnip";
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
        # { name = "copilot"; }
      ];
    };
  };

  extraConfigLuaPost = ''
    do
      local cmp = require "cmp"
      -- Set configuration for specific filetype.
      ---@diagnostic disable-next-line: missing-fields
      cmp.setup.filetype("gitcommit", {
        sources = cmp.config.sources({
          { name = "cmp_git" }, -- You can specify the `cmp_git` source if you were installed it.
        }, {
          { name = "buffer" },
        }),
      })

      -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
      ---@diagnostic disable-next-line: missing-fields
      cmp.setup.cmdline({"/", "?"}, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = "buffer" },
        },
      })

      -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
      ---@diagnostic disable-next-line: missing-fields
      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = "path" },
        }, {
          { name = "cmdline" },
        }),
      })

      ---@diagnostic disable-next-line: missing-fields
      cmp.setup.filetype({ "sql", "mysql", "plsql" }, {
        sources = cmp.config.sources({
          { name = "vim-dadbod-completion" },
        }, {
          { name = "buffer" },
        }),
      })
    end
  '';
}
