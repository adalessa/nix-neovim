{pkgs, ...}:
{
  extraPlugins = [pkgs.vimPlugins.lualine-nvim];

  extraConfigLua = ''
    require("lualine").setup({
      options = {
        theme = "auto",
        icons_enabled = true,
        globalstatus = true,
      },
      extensions = { "quickfix" },
      sections = {
        lualine_a = { { "mode", upper = true } },
        lualine_b = { { "branch", icon = "" }, "db_ui#statusline" },
        lualine_c = { { "filename", file_status = true, path = 1 } },
        lualine_x = {
          "diagnostics",
          "diff",
          {
            "require('laravel.status').get('php')",
            icon = {" ", color = { fg = "5e79be" }, },
          },
          {
            "require('laravel.status').get('laravel')",
            icon = {" ", color = { fg = "f9322c" }, },
          },
        },
        lualine_y = { "filetype" },
        lualine_z = { "location" },
      },
      winbar = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { "filename" },
        lualine_x = {},
        lualine_y = {},
        lualine_z = {},
      },
      inactive_winbar = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { "filename" },
        lualine_x = {},
        lualine_y = {},
        lualine_z = {},
      },
    })
  '';
}
