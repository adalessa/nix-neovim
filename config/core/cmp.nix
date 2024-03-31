{
  plugins = {
    cmp-buffer.enable = true;
    cmp-path.enable = true;
    cmp-nvim-lsp.enable = true;
    cmp_luasnip.enable = true;
    cmp-cmdline.enable = true;
    cmp-git.enable = true;
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
        window.completion.border = "rounded";
        window.documentation.border = "rounded";
        formatting.format = ''
          function (entry, vim_item)
              local KIND_ICONS = {
                Tailwind = '󰹞󰹞󰹞󰹞󰹞󰹞󰹞󰹞',
                Color = ' ',
                -- Class = 7,
                -- Constant = '󰚞',
                -- Constructor = 4,
                -- Enum = 13,
                -- EnumMember = 20,
                -- Event = 23,
                -- Field = 5,
                -- File = 17,
                -- Folder = 19,
                -- Function = 3,
                -- Interface = 8,
                -- Keyword = 14,
                -- Method = 2,
                -- Module = 9,
                -- Operator = 24,
                -- Property = 10,
                -- Reference = 18,
                Snippet = " ",
                -- Struct = 22,
                -- Text = "",
                -- TypeParameter = 25,
                -- Unit = 11,
                -- Value = 12,
                -- Variable = 6
              }
              if vim_item.kind == 'Color' and entry.completion_item.documentation then
                  local _, _, r, g, b =
                      ---@diagnostic disable-next-line: param-type-mismatch
                      string.find(entry.completion_item.documentation, '^rgb%((%d+), (%d+), (%d+)')

                  if r and g and b then
                      local color = string.format('%02x', r) .. string.format('%02x', g) .. string.format('%02x', b)
                      local group = 'Tw_' .. color

                      if vim.api.nvim_call_function('hlID', { group }) < 1 then
                          vim.api.nvim_command('highlight' .. ' ' .. group .. ' ' .. 'guifg=#' .. color)
                      end

                      vim_item.kind = KIND_ICONS.Tailwind
                      vim_item.kind_hl_group = group

                      return vim_item
                  end
              end

              vim_item.kind = KIND_ICONS[vim_item.kind] or vim_item.kind

              return vim_item
          end
        '';
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
