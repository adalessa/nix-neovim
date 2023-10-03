{
  plugins.fugitive.enable = true;

  keymaps = [
    {
      mode = "n";
      key = "<leader>ga";
      action = ":Git fetch --all -p<cr>";
    }
    {
      mode = "n";
      key = "<leader>gl";
      action = ":Git pull<cr>";
    }
    {
      mode = "n";
      key = "<leader>gdh";
      action = ":diffget //2<cr>";
    }
    {
      mode = "n";
      key = "<leader>gdh";
      action = ":diffget //3<cr>";
    }
  ];
}
