{
  pkgs,
  helpers,
  ...
}: {
  imports = [./telescope-ui.nix];

  extraPackages = [pkgs.fd pkgs.ripgrep];

  plugins.telescope = {
    enable = true;
    settings.defaults = {
      layout_strategy = "vertical";
      layout_config = {
        preview_cutoff = 20;
        mirror = true;
        prompt_position = "top";
      };
      prompt_prefix = "🔍 ";
      selection_caret = "👉 ";
    };
    extensions = {
      fzf-native.enable = true;
    };
    keymaps = {
      "<leader>fg" = {
        action = "live_grep";
        options = {
          desc = "Telescope Live Grep";
        };
      };
      "<leader>ph" = {
        action = "help_tags";
        options = {
          desc = "Telescope Help";
        };
      };
      "<leader>pe" = {
        action = "buffers";
        options = {
          desc = "Telescope Buffers";
        };
      };
      "<leader>pr" = {
        action = "treesitter";
        options = {
          desc = "Telescope Treesitter";
        };
      };
    };
  };

  keymaps = [
    {
      mode = "n";
      key = "<leader>pp";
      options.desc = "Telescope Git Files";
      action = helpers.mkRaw ''
        function()
          local opts = { show_untracked = true }
          local ok = pcall(require("telescope.builtin").git_files, opts)
          if not ok then
            require("telescope.builtin").find_files(opts)
          end
        end
      '';
    }
    {
      mode = "n";
      key = "<leader>pd";
      options.desc = "Telescope Document symbol";
      action = helpers.mkRaw ''
        function()
          require('telescope.builtin').lsp_document_symbols()
        end
      '';
    }
    {
      mode = "n";
      key = "<leader>pw";
      options.desc = "Grep current word";
      action = helpers.mkRaw ''
        function()
          require('telescope.builtin').grep_string { search = vim.fn.expand '<cword>' }
        end
      '';
    }
    {
      mode = "n";
      key = "<leader>ps";
      options.desc = "Grep in project";
      action = helpers.mkRaw ''
        function()
          vim.ui.input({ prompt = "Grep for > " }, function(input)
            if input == nil then
              return
            end
            require("telescope.builtin").grep_string { search = input }
          end)
        end
      '';
    }
    {
      mode = "n";
      key = "<leader>gc";
      options.desc = "Telescope Git Branches";
      action = helpers.mkRaw ''
        function()
          local actions = require "telescope.actions"
          require("telescope.builtin").git_branches {
            attach_mappings = function(_, map)
              map("i", "<c-j>", actions.git_create_branch)
              map("n", "<c-j>", actions.git_create_branch)
              return true
            end,
          }
        end
      '';
    }
    {
      mode = "n";
      key = "<leader>gs";
      options.desc = "Telescope Git Status";
      action = helpers.mkRaw ''
        function()
          require("telescope.builtin").git_status()
        end
      '';
    }
  ];
}
