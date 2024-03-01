{
  plugins.neogit = {
    enable = true;
    settings.integrations.diffview = true;
  };

  plugins.diffview.enable = true;

  keymaps = [
    {
      mode = "n";
      key = "<leader>gg";
      options.desc = "Open Neoggit";
      action = ":Neogit<cr>";
    }
  ];
}
