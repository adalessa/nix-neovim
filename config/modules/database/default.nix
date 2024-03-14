{pkgs, ...}: {
  extraPlugins = with pkgs.vimPlugins; [
    vim-dotenv
    vim-dadbod-completion
    vim-dadbod
    vim-dadbod-ui
  ];

  extraPackages = [pkgs.mariadb pkgs.sqlite];

  globals = {
    db_ui_use_nerd_fonts = 1;
    db_ui_show_database_icon = 1;
    db_ui_force_echo_notifications = 1;
    db_ui_win_position = "left";
    db_ui_winwidth = 80;
    db_ui_table_helpers = {
      mysql = {
        Count = "select count(1) from {optional_schema}{table}";
        Explain = "EXPLAIN {last_query}";
      };
      sqlite = {Describe = "PRAGMA table_info({table})";};
    };
  };

  keymaps = [
    {
      mode = "n";
      key = "<leader><leader>db";
      action = ":DBUIToggle<cr>";
    }
  ];
}
