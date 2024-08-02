{ helpers, ... }:
{
  autoCmd = [
    {
      event = [ "BufWritePre" ];
      desc = "Remove trailing whitespace";
      command = ":%s/\\s\\+$//e";
    }
    {
      event = [ "FileType" ];
      pattern = [
        "dbout"
        "fugitive"
        "git"
        "help"
        "lspinfo"
        "man"
        "notify"
        "PlenaryTestPopup"
        "qf"
        "spectre_panel"
        "startuptime"
        "tsplayground"
      ];
      callback = helpers.mkRaw ''
        function(event)
          vim.bo[event.buf].buflisted = false
          vim.keymap.set("n", "q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
        end
      '';
    }
    {
      event = [ "FileType" ];
      pattern = [ "dbout" ];
      callback = helpers.mkRaw ''
        function()
          vim.cmd([[setlocal nofoldenable]])
        end
      '';
    }
    {
      event = [ "FileType" ];
      pattern = [ "json" ];
      callback = helpers.mkRaw ''
        function()
          local set = vim.bo
          set.expandtab = true
          set.tabstop = 2
          set.softtabstop = 2
          set.shiftwidth = 2
        end
      '';
    }
  ];
}
