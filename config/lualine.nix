{
  plugins.lualine = {
    enable = true;
    globalstatus = true;
    extensions = [ "quickfix" "fugitive" ];
    winbar.lualine_c = [ "filename" ];
    inactiveWinbar.lualine_c = [ "filename" ];
    sections.lualine_c = [
      {
        name = "filename";
        extraConfig = {
          file_status = true;
          path = 1;
        };
      }
    ];
    sections.lualine_x = [
      "diagnostics"
      "diff"
    ];

    sections.lualine_y = [
      "filetype"
    ];

    sections.lualine_z = [
      "location"
    ];
  };
}
