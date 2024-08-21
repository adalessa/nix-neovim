{
  plugins.lualine.sections = {
    lualine_x = [
      {
        name = "require('laravel').app('status'):get('php')";
        icon = {
          icon = " ";
          color.fg = "5e79be";
        };
      }
      {
        name = "require('laravel').app('status'):get('laravel')";
        icon = {
          icon = " ";
          color.fg = "f9322c";
        };
      }
    ];
  };
}
