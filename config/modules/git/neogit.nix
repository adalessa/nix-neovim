{
  plugins.neogit = {
    enable = true;
    integrations.diffview = true;
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
