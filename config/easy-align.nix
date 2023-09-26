{pkgs,...}: {
  extraPlugins = with pkgs.vimPlugins; [
    vim-easy-align
  ];

  map.normalVisualOp.ga = {
    action = "<Plug>(EasyAlign)";
    desc = "EasyAlign";
  };
}
