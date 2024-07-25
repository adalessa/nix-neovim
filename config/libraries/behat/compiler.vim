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
