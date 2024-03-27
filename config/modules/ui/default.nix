{pkgs, ...}: {
  imports = [./dressing.nix ./lualine.nix ./colorscheme.nix ./borders.nix];

  plugins.nvim-colorizer.enable = true;

  plugins.notify = {
    enable = true;
    backgroundColour = "#000000";
  };

  keymaps = [
    {
      mode = "n";
      key = "<leader>q";
      options.desc = "Dismiss notifications";
      lua = true;
      action = ''
        function()
          require('notify').dismiss()
        end
      '';
    }
  ];

  extraPlugins = with pkgs.vimPlugins; [
    nvim-web-devicons
  ];
}
