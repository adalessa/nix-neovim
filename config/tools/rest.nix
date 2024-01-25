{
  plugins.rest = {
    enable = true;
  };

  filetype.pattern.".*%.http" = "http";

  autoCmd = [
    {
      event = ["FileType"];
      pattern = ["http"];
      callback = {
        __raw = ''
          function (event)
              vim.keymap.set("n", "<LocalLeader>r", require('rest-nvim').run, { buffer = event.buf, silent = true })
          end
        '';
      };
    }
  ];
}
