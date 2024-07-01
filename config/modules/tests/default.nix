{pkgs, ...}: {
  extraPlugins = with pkgs.vimPlugins; [
    hydra-nvim
    vim-test
    vim-dispatch
  ];

  globals = {
    "test#strategy" = "dispatch";
    "test#neovim#term_position" = "vert";
    "test#php#behat#executable" = "bin/behat";
    "test#php#behat#options" = "--colors";
  };

  # TODO: want to revisit how to set this maybe a function
  extraConfigLua = ''
    do
      ${builtins.readFile ./test.lua}
    end
  '';

  extraConfigVim = ''
    let g:dispatch_compilers = {
      \ './vendor/bin/pest': 'pest',
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
  };
}
