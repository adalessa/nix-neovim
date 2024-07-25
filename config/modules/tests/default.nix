{pkgs, ...}: {
  extraPlugins = with pkgs.vimPlugins; [
    vim-test
    vim-dispatch
  ];

  globals = {
    "test#strategy" = "dispatch";
  };

  plugins.hydra = {
    enable = true;
    hydras = [
      {
        body = "<leader>t";
        mode = "n";
        name = "Tests";
        config = {
          color = "teal";
          invoke_on_body = true;
        };
        heads = [
          ["n" ":TestNearest<CR>" {desc = "Nearest";}]
          ["f" ":TestFile<CR>" {desc = "File";}]
          ["s" ":TestSuit<CR>" {desc = "Suit";}]
          ["l" ":TestLast<CR>" {desc = "Last";}]
          [
            "<Esc>"
            null
            {exit = true;}
          ]
        ];
      }
    ];
  };
}
