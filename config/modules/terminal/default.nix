{
  plugins.floaterm = {
    enable = true;
  };

  keymaps = [
    {
      mode = "n";
      key = "<leader>st";
      options.desc = "";
      action = ":FloatermToggle<cr>";
    }
    {
      mode = "t";
      key = "<c-h>";
      options.desc = "";
      action = "<Cmd>:FloatermHide<cr>";
    }
    {
      mode = "t";
      key = "<c-w>";
      options.desc = "";
      action = "<Cmd>:FloatermKill<cr>";
    }
    {
      mode = "t";
      key = "<c-t>";
      options.desc = "";
      action = "<Cmd>:FloatermNew<cr>";
    }
    {
      mode = "t";
      key = "<c-j>";
      options.desc = "";
      action = "<Cmd>:FloatermNext<cr>";
    }
    {
      mode = "t";
      key = "<c-k>";
      options.desc = "";
      action = "<Cmd>:FloatermPrev<cr>";
    }
  ];
}
