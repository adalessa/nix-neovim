{pkgs,...}: {
  extraPlugins = with pkgs.vimPlugins; [
    vim-easy-align
  ];

  maps.normalVisualOp.ga = {
    action = "<Plug>(EasyAlign)";
    desc = "EasyAlign";
  };
}
