{
  plugins.lualine = {
    enable = true;
    globalstatus = true;
    iconsEnabled = true;
    theme = "auto";
    extensions = ["quickfix"];

    sections = {
      lualine_a = [
        {
          name = "mode";
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

      lualine_y = ["filetype"];
      lualine_z = ["location"];
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
