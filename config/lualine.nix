{
  plugins.lualine = {
    enable = true;
    globalstatus = true;
    extensions = ["quickfix" "fugitive"];
    winbar.lualine_c = ["filename"];
    inactiveWinbar.lualine_c = ["filename"];
  };
}
