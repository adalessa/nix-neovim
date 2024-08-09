{
  plugins.toggleterm = {
    enable = true;
    settings = {
      open_mapping = "[[<c-\\>]]";
      winbar.enabled = false;
      size = 15;
      float_opts.border = "rounded";
    };
  };
  # What I want to be easy with the toogle term ?
  # Should be using a make a selector with hydra ?
  # could C-\ be the head ? or that is the simple
  # and other keybinding be the head.
  # could enable the hydra with <leader><c-\>
}
