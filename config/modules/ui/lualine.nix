{
  plugins.lualine = {
    enable = true;
    globalstatus = true;
    iconsEnabled = true;
    theme = "auto";
    extensions = [ "quickfix" ];
    componentSeparators = {
      left = "";
      right = "";
    };
    sectionSeparators = {
      left = "";
      right = "";
    };

    sections = {
      lualine_a = [
        {
          name = "mode";
          icon = {
            icon = " ";
            color = {
              fg = "008A3D";
            };
          };
          extraConfig = {
            upper = true;
          };
        }
      ];
      lualine_b = [
        {
          name = "branch";
          icon = "";
        }
        "db_ui#statusline"
      ];
      lualine_c = [
        {
          name = "filename";
          extraConfig = {
            file_status = true;
            path = 1;
          };
        }
      ];

      lualine_x = [
        "diagnostics"
        "diff"
      ];

      lualine_y = [ "filetype" ];
      lualine_z = [ "location" ];
    };
    # inactiveWinbar = {
    #   lualine_c = [
    #     {
    #       name = "filename";
    #       extraConfig = {
    #         file_status = true;
    #         path = 1;
    #       };
    #     }
    #   ];
    # };
  };
}
