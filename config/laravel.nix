{ pkgs, ... }: {
  extraPlugins = with pkgs.vimPlugins; [ nui-nvim laravel ];

  extraConfigLua = ''
    require('laravel').setup()
  '';

  keymaps = [
    {
      mode = "n";
      key = "<leader>la";
      action = ":Laravel artisan<cr>";
    }
    {
      mode = "n";
      key = "<leader>lr";
      action = ":Laravel routes<cr>";
    }
  ];
}