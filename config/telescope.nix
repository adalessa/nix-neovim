let
  helper = import ../helper.nix;
in {
  plugins.telescope = {
    enable = true;
    extensions = {
      file_browser = {
        enable = true;
        path = "%:p:h";
        mappings = {
          "i" = {
            "<c-y>" = "create_from_prompt";
          };
        };
      };
      fzf-native.enable = true;
    };
    keymaps = {
      "<leader>fg" = {action = "live_grep"; desc = "Telescope Live Greoup";};
      "<leader>ph" = {action = "help_tags"; desc = "Telescope Help";};
      "<leader>pe" = {action = "buffers"; desc = "Telescope Buffers";};
      "<leader>pr" = {action = "treesitter"; desc = "Telescope Treesitter";};
    };
  };

  maps.normal = {
    "<leader>pp" = helper.mkLuaKeymap {
      action = ''
        local opts = { show_untracked = true }
        local ok = pcall(require("telescope.builtin").git_files, opts)
        if not ok then
          require("telescope.builtin").find_files(opts)
        end
      '';
      desc = "Telescope Git Files";
    };
    "<leader>bb" = {
      silent = true;
      action = ":Telescope file_browser path=%:p:h select_buffer=true<CR>";
      desc = "Telescope File Browser";
    };
    "<leader>pw" = helper.mkLuaKeymap {
      action = "require('telescope.builtin').grep_string { search = vim.fn.expand '<cword>' }";
      desc = "Grep current word";
    };
    "<leader>ps" = helper.mkLuaKeymap {
      action = ''
        vim.ui.input({ prompt = "Grep for > " }, function(input)
          if input == nil then
            return
          end
          require("telescope.builtin").grep_string { search = input }
        end)
      '';
      desc = "Grep in project";
    };
    "<leader>gc" = helper.mkLuaKeymap {
      action = ''
        local actions = require "telescope.actions"
        require("telescope.builtin").git_branches {
          attach_mappings = function(_, map)
            map("i", "<c-j>", actions.git_create_branch)
            map("n", "<c-j>", actions.git_create_branch)
            return true
          end,
        }
      '';
      desc = "Telescope Git Branches";
    };
  };
}
