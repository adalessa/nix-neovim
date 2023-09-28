{
  autoCmd = [
    {
      event = [ "BufWritePre" ];
      description = "Remove trailing whitespace";
      command = ":%s/\\s\\+$//e";
    }
    {
      event = [ "FileType" ];
      pattern = [
        "git"
        "qf"
        "help"
        "man"
        "notify"
        "fugitive"
        "lspinfo"
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
  ];
}
