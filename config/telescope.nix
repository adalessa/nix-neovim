{
  plugins.telescope = {
    enable = true;
    extensions = {
      file_browser = {
        enable = true;
        hijackNetrw = true;
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

  maps = {
    normal."<leader>bb" = {
      silent = true;
      action = ":Telescope file_browser path=%:p:h select_buffer=true<CR>";
    };
    normal."<leader>pw" = {
      silent = true;
      lua = true;
      action = ''
        function ()
          require('telescope.builtin').grep_string { search = vim.fn.expand '<cword>' }
        end
      '';
    };
    normal."<leader>ps" = {
      silent = true;
      lua = true;
      action = ''
        function()
          vim.ui.input({ prompt = "Grep for > " }, function(input)
            if input == nil then
              return
            end
            require("telescope.builtin").grep_string { search = input }
          end)
        end
      '';
    };
  };
}
