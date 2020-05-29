if exists('g:loaded_make_test')
  finish
endif

let g:loaded_make_test = 1

function MakeTestFileLine()
  let path=@%
  let lineNumber=line('.') + 1

  ExecuteTest("make test FILE=" . path . ':' . lineNumber)
endfunction

function MakeTestFile()
  let path=@%

  ExecuteTest("make test FILE=" . path)
endfunction

function ExecuteTest(cmd)
  if has('nvim')
    " start new dialog on the bottom
    execute "botright" . ' new'

    " execute command
    call termopen(cmd)

    " switch back to last window
    au BufDelete <buffer> wincmd p
    startinsert
  else
    execute "!" . cmd
  endif
endfunction

command! -bar MakeTestFileLine call MakeTestFileLine()
command! -bar MakeTestFile     call MakeTestFile()
