if exists('g:make_test_loaded')
  finish
endif

let g:make_test_loaded = 1
let g:make_test_dialog_position = 'botright' " top, topleft, topright, bottom, bottomleft, bottomright, tab
let g:make_test_command_pattern = 'make -s test FILE=%s'

function! MakeTestFileLine()
  let path=RelativePath(@%)
  let lineNumber=line('.') + 1

  let cmd=printf(g:make_test_command_pattern, path . ':' . lineNumber)

  " start new dialog on the bottom
  execute g:make_test_dialog_position . ' new'

  " execute command
  call termopen(cmd)

  " switch back to last window
  au BufDelete <buffer> wincmd p
  startinsert
endfunction

function! MakeTestFile()
  let path=RelativePath(@%)

  let cmd=printf(g:make_test_command_pattern, path)

  " start new dialog on the bottom
  execute g:make_test_dialog_position . ' new'

  " execute command
  call termopen(cmd)

  " switch back to last window
  au BufDelete <buffer> wincmd p
  startinsert
endfunction

function! MakeTestBottom()
  let g:make_test_dialog_position = 'botright'
endfunction

function! MakeTestRight()
  let g:make_test_dialog_position = 'right'
endfunction

function! MakeTestAsTab()
  let g:make_test_dialog_position = 'tab'
endfunction

function! s:RelativePath(filepath)
  let l:absolute_path = fnamemodify(a:filepath, ':p')
  let l:cwd = getcwd()
  let l:rel_path = substitute(l:absolute_path, '^' . l:cwd . '/', '', '')

  return l:rel_path
endfunction

command! -bar MakeTestFileLine call MakeTestFileLine()
command! -bar MakeTestFile     call MakeTestFile()
