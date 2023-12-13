{
  plugins.oil = {
    enable = true;
  };

  keymaps = [
    {
      mode = "n";
      key = "-";
      options.desc = "Open parent directiory";
      action = "<CMD>Oil<CR>";
    }
    {
      mode = "n";
      key = "<leader>-";
      options.desc = "Open parent directiory";
      action = "<CMD>Oil --float<CR>";
    }
  ];
}
