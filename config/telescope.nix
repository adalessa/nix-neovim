let 
  keymap = {action, desc}: {
    lua = true;
    silent = true;
    desc = desc;
    action = "function() ${action} end";
  };
in{
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
      "<leader>pp" = {
        action = "git_files";
        desc = "Telescope Git Files";
      };
      "<leader>fg" = "live_grep";
      "<leader>ph" = "help_tags";
      "<leader>pe" = "buffers";
      "<leader>pr" = "treesitter";
    };
  };

  maps.normal = {
    "<leader>bb" = {
      silent = true;
      action = ":Telescope file_browser path=%:p:h select_buffer=true<CR>";
    };
    "<leader>pw" = keymap {
      action = "require('telescope.builtin').grep_string { search = vim.fn.expand '<cword>' }";
      desc = "Grep current word";
    };
    "<leader>ps" = keymap {
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
  };
}
