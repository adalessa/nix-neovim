{pkgs, ...}: {
  imports = [./dressing.nix ./lualine.nix];

  colorschemes.tokyonight.enable = true;

  plugins.nvim-colorizer.enable = true;

  plugins.notify = {
    enable = true;
    backgroundColour = "#000000";
  };

  extraPlugins = with pkgs.vimPlugins; [
    nvim-web-devicons
  ];
}
