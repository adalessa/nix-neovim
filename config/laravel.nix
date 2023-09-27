{pkgs, ...}: let helper = import ../helper.nix; in {
  extraPlugins = with pkgs.vimPlugins; [
    nui-nvim
    {
      plugin = laravel;
      config = helper.toLua "require('laravel').setup()";
    }
  ];

  maps.normal = {
    "<leader>la" = ":Laravel artisan<cr>";
    "<leader>lr" = ":Laravel routes<cr>";
  };
}
