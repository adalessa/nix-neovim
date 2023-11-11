{pkgs, ...}: let
  helper = import ../helper.nix;
  inherit (helper) luaAction;
in {
  imports = [./telescope-ui.nix ./telescope-graphql.nix];

  extraPackages = [pkgs.fd];

  plugins.telescope = {
    enable = true;
    extensions = {
      file_browser = {
        enable = true;
        path = "%:p:h";
        mappings = {"i" = {"<c-y>" = "create_from_prompt";};};
      };
      fzf-native.enable = true;
    };
    keymaps = {
      "<leader>fg" = {
        action = "live_grep";
        desc = "Telescope Live Greoup";
      };
      "<leader>ph" = {
        action = "help_tags";
        desc = "Telescope Help";
      };
      "<leader>pe" = {
        action = "buffers";
        desc = "Telescope Buffers";
      };
      "<leader>pr" = {
        action = "treesitter";
        desc = "Telescope Treesitter";
      };
    };
  };

  keymaps = [
    {
      mode = "n";
      key = "<leader>pp";
      options.desc = "Telescope Git Files";
      lua = true;
      action = luaAction ''
        local opts = { show_untracked = true }
        local ok = pcall(require("telescope.builtin").git_files, opts)
        if not ok then
          require("telescope.builtin").find_files(opts)
        end
      '';
    }
    {
      mode = "n";
      key = "<leader>bb";
      options.desc = "Telescope File Browser";
      action = ":Telescope file_browser path=%:p:h select_buffer=true<CR>";
    }
    {
      mode = "n";
      key = "<leader>pd";
      options.desc = "Telescope Document symbol";
      lua = true;
      action = luaAction ''
        require('telescope.builtin').lsp_document_symbols()
      '';
    }
    {
      mode = "n";
      key = "<leader>pw";
      options.desc = "Grep current word";
      lua = true;
      action =
        luaAction
        "require('telescope.builtin').grep_string { search = vim.fn.expand '<cword>' }";
    }
    {
      mode = "n";
      key = "<leader>ps";
      options.desc = "Grep in project";
      lua = true;
      action = luaAction ''
        vim.ui.input({ prompt = "Grep for > " }, function(input)
          if input == nil then
            return
          end
          require("telescope.builtin").grep_string { search = input }
        end)
      '';
    }
    {
      mode = "n";
      key = "<leader>gc";
      options.desc = "Telescope Git Branches";
      lua = true;
      action = luaAction ''
        local actions = require "telescope.actions"
        require("telescope.builtin").git_branches {
          attach_mappings = function(_, map)
            map("i", "<c-j>", actions.git_create_branch)
            map("n", "<c-j>", actions.git_create_branch)
            return true
          end,
        }
      '';
    }
    {
      mode = "n";
      key = "<leader>gs";
      options.desc = "Telescope Git Status";
      lua = true;
      action = luaAction ''
        require("telescope.builtin").git_status()
      '';
    }
  ];
}
