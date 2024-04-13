{helpers, ...}: {
  plugins.telescope = {
    extensions.ui-select.enable = true;
    settings.extensions."ui-select" = helpers.mkRaw "{require('telescope.themes').get_dropdown({})}";
  };
}
