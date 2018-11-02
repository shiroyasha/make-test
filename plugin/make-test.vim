if exists('g:loaded_make_test')
  finish
endif

let g:loaded_make_test = 1

function MakeTestFileLine()
  let path=@%
  let lineNumber=line('.') + 1

  let cmd="make test FILE=".path.':'.lineNumber

  " start new dialog on the bottom
  execute "botright" . ' new'

  " execute command
  call termopen(cmd)

  " switch back to last window
  au BufDelete <buffer> wincmd p
  startinsert
endfunction

function MakeTestFile()
  let path=@%

  let cmd="make test FILE=".path

  " start new dialog on the bottom
  execute "botright" . ' new'

  " execute command
  call termopen(cmd)

  " switch back to last window
  au BufDelete <buffer> wincmd p
  startinsert
endfunction

command! -bar MakeTestFileLine call MakeTestFileLine()
command! -bar MakeTestFile     call MakeTestFile()
