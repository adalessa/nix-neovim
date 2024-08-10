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

  keymaps =
    builtins.map
      (index: {
        mode = [
          "n"
          "t"
        ];
        key = "<F${toString (index + 5)}>";
        action = "<Cmd> ${toString index}ToggleTerm direction=float<cr>";
        options.silent = true;
      })
      [
        1
        2
        3
        4
      ]
    ++ builtins.map
      (index: {
        mode = [
          "n"
        ];
        key = "<leader><F${toString (index + 5)}>";
        action = "<Cmd> ${toString index}ToggleTerm direction=horizontal<cr>";
        options.silent = true;
      })
      [
        1
        2
        3
        4
      ];
}
