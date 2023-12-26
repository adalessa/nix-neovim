{pkgs, ...}: {
  extraPlugins = [pkgs.extraVimPlugins.cyberdream];

  extraConfigLua = ''
    require("cyberdream").setup({
      transparent = true, -- enable transparent background
      italic_comments = true, -- italicize comments
      hide_fillchars = true, -- replace all fillchars with ' ' for the ultimate clean look
    })
    vim.cmd("colorscheme cyberdream")
  '';
}
