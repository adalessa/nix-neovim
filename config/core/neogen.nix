{
  plugins.neogen = {
    enable = true;
    snippetEngine = "luasnip";
  };
  keymaps = [
    {
      mode = "n";
      key = "<leader>n";
      options.desc = "Generate comments";
      action = ":Neogen<cr>";
    }
  ];
}
