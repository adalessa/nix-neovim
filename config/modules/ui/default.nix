{
  pkgs,
  helpers,
  ...
}: {
  imports = [
    ./dressing.nix
    ./lualine.nix
    ./borders.nix
    ./start.nix
  ];
  plugins = {
    nvim-colorizer.enable = true;

    notify = {
      enable = true;
      backgroundColour = "#000000";
    };
  };

  keymaps = [
    {
      mode = "n";
      key = "<leader>q";
      options.desc = "Dismiss notifications";
      action = helpers.mkRaw ''
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
