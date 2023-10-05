{ pkgs, ... }: {
  plugins.telescope.extensionConfig = {
    "ui-select" = {
      __raw = "require('telescope.themes').get_dropdown({})";
    };
  };

  plugins.telescope.enabledExtensions = [ "ui-select" ];
  extraPlugins = with pkgs.vimPlugins; [ telescope-ui-select-nvim ];
}
