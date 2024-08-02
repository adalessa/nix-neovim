{
  plugins.cmp.settings = {
    window.completion.border = "rounded";
    window.documentation.border = "rounded";
    formatting = {
      fields = [
        "menu"
        "abbr"
        "kind"
      ];
      format = ''
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
              -- Snippet = " ",
              -- Struct = 22,
              -- Text = "",
              -- TypeParameter = 25,
              -- Unit = 11,
              -- Value = 12,
              -- Variable = 6
            }

            vim_item.menu = ({
              buffer = "📄",
              nvim_lsp = "🔍",
              luasnip = "🌩️",
              nvim_lua = " ",
              ["vim-dadbod-completion"] = "💾",
              cmdline = "💻",
              path = "🐧",
              copilot = "🤖",
            })[entry.source.name]

            vim_item.menu_hl_group = ({
              buffer = "DevIconFs",
              nvim_lsp = "DevIconMl",
              luasnip = "DevIconAi",
              nvim_lua = "DevIconVim",
              ["vim-dadbod-completion"] = "DevIconDb",
              cmdline = "DevIconTerminal",
              path = "DevIconLinux",
            })[entry.source.name]

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

            vim_item.kind = KIND_ICONS[vim_item.kind] or string.format("(%s)", vim_item.kind)

            return vim_item
        end
      '';
    };
  };
}
