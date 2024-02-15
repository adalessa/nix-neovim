{pkgs, ...}: {
  plugins.toggleterm = {
    enable = true;
    openMapping = "<C-\\>";
    winbar.enabled = true;
    size = 18;
  };
  extraPlugins = [pkgs.extraVimPlugins.toggleterm-manager];
  extraConfigLua = ''
    require('toggleterm-manager').setup()
  '';
}
