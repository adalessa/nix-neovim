{
  pkgs,
  inputs,
  ...
}: let
  oldworld = pkgs.vimUtils.buildVimPlugin {
    name = "oldworld";
    src = inputs.colorscheme-oldworld;
  };
in {
  # colorschemes = {
  #   catppuccin.enable = true;
  # };
  extraPlugins = [oldworld];
  extraConfigLuaPost = ''
    vim.cmd.colorscheme "oldworld"
  '';

  highlightOverride = {
    # NeogitDiffAddHighlight xxx cterm= gui= guifg=#90b99f guibg=#90b99f
    NeogitDiffAddHighlight.fg = "#8d84aa";
    # NeogitDiffDeleteHighlight xxx cterm= gui= guifg=#f5a191 guibg=#f5a191
    NeogitDiffDeleteHighlight.fg = "#737374";
  };
}
