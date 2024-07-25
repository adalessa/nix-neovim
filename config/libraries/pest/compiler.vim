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
