{pkgs, ...}: {
  plugins.toggleterm = {
    enable = true;
    openMapping = "<C-\\>";
    winbar.enabled = true;
  };
  extraPlugins = [pkgs.extraVimPlugins.toggleterm-manager];
  extraConfigLua = ''
    require('toggleterm-manager').setup()
  '';
}
