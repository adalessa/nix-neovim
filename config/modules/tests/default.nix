{pkgs, ...}: {
  extraPlugins = with pkgs.vimPlugins; [
    vim-test
    vim-dispatch
  ];

  globals = {
    "test#strategy" = "dispatch";
    "test#php#behat#executable" = "bin/behat";
  };

  extraConfigLua = builtins.readFile ./test.lua;

  extraConfigVim = ''
    let g:dispatch_compilers = {
      \ './vendor/bin/pest': 'pest',
      \ 'bin/behat': 'behat',
      \ 'behat': 'behat',
      \ './vendor/bin/behat': 'behat',
      \}
  '';

  extraFiles = {
    "compiler/pest.vim" = ''
      if exists('current_compiler')
        finish
      endif
      let g:current_compiler = 'pest'

      if exists(':CompilerSet') != 2  " older Vim always used :setlocal
        command -nargs=* CompilerSet setlocal <args>
      endif

      let s:cpo_save = &cpoptions
      set cpoptions-=C

      CompilerSet makeprg=pest
      CompilerSet errorformat=\ \ at\ %f:%l

      let &cpoptions = s:cpo_save
      unlet s:cpo_save
    '';
    "compiler/behat.vim" = ''
      if exists('current_compiler')
        finish
      endif
      let g:current_compiler = 'behat'

      if exists(':CompilerSet') != 2  " older Vim always used :setlocal
        command -nargs=* CompilerSet setlocal <args>
      endif

      let s:cpo_save = &cpoptions
      set cpoptions-=C

      CompilerSet makeprg=behat
      CompilerSet errorformat=\ \ \ \ %f:%l

      let &cpoptions = s:cpo_save
      unlet s:cpo_save
    '';
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
