{
  plugins = {
    copilot-cmp.enable = true;
    copilot-lua = {
      enable = true;
      panel.enabled = false;
      suggestion.enabled = false;
    };
    cmp.settings.sources = [
      {
        name = "copilot";
        group_index = 1;
      }
    ];
  };
}
