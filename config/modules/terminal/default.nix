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
      key = "<c-t>";
      options.desc = "";
      action = "<c-\\><c-n>:FloatermToggle<cr>";
    }
  ];
}
