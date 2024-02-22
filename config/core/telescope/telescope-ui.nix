{helpers, ...}: {
  plugins.telescope = {
    extensions.ui-select.enable = true;
    extensionConfig = {
      "ui-select" = helpers.mkRaw "require('telescope.themes').get_dropdown({})";
    };
  };
}
