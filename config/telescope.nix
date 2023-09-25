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
    };
  };

  maps = {
    normal."<leader>bb" = {
      silent = true;
      action = ":Telescope file_browser path=%:p:h select_buffer=true<CR>";
    };
  };
}
