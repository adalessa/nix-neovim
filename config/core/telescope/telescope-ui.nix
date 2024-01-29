{
  plugins.telescope = {
    extensions.ui-select.enable = true;
    extensionConfig = {
      "ui-select" = {
        __raw = "require('telescope.themes').get_dropdown({})";
      };
    };
  };
}
