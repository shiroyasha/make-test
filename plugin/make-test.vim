if exists('g:loaded_make_test')
  finish
endif

let g:loaded_make_test = 1

function MakeTestFileLine()
  let path=RelativePath(@%)
  let lineNumber=line('.') + 1

  let cmd="make -s test FILE=".path.':'.lineNumber

  " start new dialog on the bottom
  execute "botright" . ' new'

  " execute command
  call termopen(cmd)

  " switch back to last window
  au BufDelete <buffer> wincmd p
  startinsert
endfunction

function MakeTestFile()
  let path=RelativePath(@%)

  let cmd="make -s test FILE=".path

  " start new dialog on the bottom
  execute "botright" . ' new'

  " execute command
  call termopen(cmd)

  " switch back to last window
  au BufDelete <buffer> wincmd p
  startinsert
endfunction

function! RelativePath(filepath)
  let l:absolute_path = fnamemodify(a:filepath, ':p')
  let l:cwd = getcwd()
  let l:rel_path = substitute(l:absolute_path, '^' . l:cwd . '/', '', '')

  return l:rel_path
endfunction

command! -bar MakeTestFileLine call MakeTestFileLine()
command! -bar MakeTestFile     call MakeTestFile()
