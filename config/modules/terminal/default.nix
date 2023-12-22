{
  plugins.floaterm = {
    enable = true;
  };

  autoCmd = [
    {
      event = ["FileType"];
      pattern = ["floaterm"];
      callback = {
        __raw = ''
          function (event)
            vim.keymap.set({"n", "t"}, "<c-h>", "<Cmd>FloatermHide<cr>", {buffer = event.buf})
            vim.keymap.set({"n", "t"}, "<c-w>", "<Cmd>FloatermKill<cr>", {buffer = event.buf})
            vim.keymap.set({"n", "t"}, "<c-t>", "<Cmd>FloatermNew<cr>", {buffer = event.buf})
            vim.keymap.set({"n", "t"}, "<c-j>", "<Cmd>FloatermNext<cr>", {buffer = event.buf})
            vim.keymap.set({"n", "t"}, "<c-k>", "<Cmd>FloatermPrev<cr>", {buffer = event.buf})
          end
        '';
      };
    }
  ];

  keymaps = [
    {
      mode = "n";
      key = "<leader>st";
      options.desc = "";
      action = ":FloatermToggle<cr>";
    }
  ];
}
