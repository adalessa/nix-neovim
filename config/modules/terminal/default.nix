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
      key = "<c-q>";
      options.desc = "";
      action = "<c-\\><c-n>:FloatermToggle<cr>";
    }
    {
      mode = "t";
      key = "<c-t>";
      options.desc = "";
      action = "<c-\\><c-n>:FloatermNew<cr>";
    }
    {
      mode = "t";
      key = "<c-n>";
      options.desc = "";
      action = "<c-\\><c-n>:FloatermNext<cr>";
    }
    {
      mode = "t";
      key = "<c-p>";
      options.desc = "";
      action = "<c-\\><c-n>:FloatermPrev<cr>";
    }
  ];
}
