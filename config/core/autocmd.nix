{
  autoCmd = [
    {
      event = ["BufWritePre"];
      desc = "Remove trailing whitespace";
      command = ":%s/\\s\\+$//e";
    }
    {
      event = ["FileType"];
      pattern = [
        "git"
        "qf"
        "help"
        "man"
        "notify"
        "fugitive"
        "lspinfo"
        "dbout"
        "spectre_panel"
        "startuptime"
        "tsplayground"
        "PlenaryTestPopup"
      ];
      callback = {
        __raw = ''
          function(event)
            vim.bo[event.buf].buflisted = false
            vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
          end
        '';
      };
    }
    {
      event = ["FileType"];
      pattern = ["dbout"];
      callback = {
        __raw = ''
          function()
            vim.cmd([[setlocal nofoldenable]])
          end
        '';
      };
    }
    {
      event = ["FileType"];
      pattern = ["json"];
      callback = {
        __raw = ''
          function()
            local set = vim.bo
            set.expandtab = true
            set.tabstop = 2
            set.softtabstop = 2
            set.shiftwidth = 2
          end
        '';
      };
    }
  ];
}
