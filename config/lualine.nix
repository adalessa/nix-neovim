{
  plugins.lualine = {
    enable = true;
    globalstatus = true;
    extensions = [ "quickfix" "fugitive" ];
    winbar.lualine_c = [ "filename" ];
    inactiveWinbar.lualine_c = [ "filename" ];
    sections.lualine_c = [{
      name = "filename";
      extraConfig = {
        file_status = true;
        path = 1;
      };
    }];
  };
}
