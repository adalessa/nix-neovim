{
  plugins.neogit = {
    enable = true;
  };
  keymaps = [
    {
        mode = "n";
        key = "<leader>gg";
        options.desc = "Open Neoggit";
        action = ":Neogit<cr>";
    }
  ];
}
