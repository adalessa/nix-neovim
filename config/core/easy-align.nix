{ pkgs, ... }:
{
  extraPlugins = with pkgs.vimPlugins; [ vim-easy-align ];

  keymaps = [
    {
      mode = [
        "n"
        "v"
      ];
      key = "ga";
      action = "<Plug>(EasyAlign)";
      options.desc = "EasyAlign";
    }
  ];
}
