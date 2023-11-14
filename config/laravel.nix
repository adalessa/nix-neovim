{pkgs, ...}: {
  extraPlugins = [pkgs.vimPlugins.nui-nvim pkgs.extraVimPlugins.laravel];

  extraPackages = [pkgs.fd];

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
    {
      mode = "n";
      key = "<leader>lh";
      action = ":Artisan docs<cr>";
    }
  ];
}
