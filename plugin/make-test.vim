if exists('g:make_test_loaded')
  finish
endif

let g:make_test_loaded = 1
let g:make_test_dialog_position = 'tab'
let g:make_test_command_pattern = 'make -s test FILE=%s'
let g:make_test_auto_close = 1

function! MakeTestFileLine()
  let path=s:RelativePath(@%)
  let lineNumber=line('.') + 1

  let cmd=printf(g:make_test_command_pattern, path . ':' . lineNumber)

  " start new dialog on the bottom
  execute g:make_test_dialog_position . ' new'

  " execute command
  call termopen(cmd)

  if g:make_test_auto_close
    " switch back to last window
    au BufDelete <buffer> wincmd p
    startinsert
  endif
endfunction

function! MakeTestFile()
  let path=s:RelativePath(@%)

  let cmd=printf(g:make_test_command_pattern, path)

  " start new dialog on the bottom
  execute g:make_test_dialog_position . ' new'

  " execute command
  call termopen(cmd)

  if g:make_test_auto_close
    " switch back to last window
    au BufDelete <buffer> wincmd p
    startinsert
  endif
endfunction

function! MakeTestBottom()
  let g:make_test_dialog_position = 'botright new'
endfunction

function! MakeTestRight()
  let g:make_test_dialog_position = 'botright vnew'
  let g:make_test_auto_close = 0
endfunction

function! MakeTestAsTab()
  let g:make_test_dialog_position = 'tab'
  let g:make_test_auto_close = 0
endfunction

function! s:RelativePath(filepath)
  let l:absolute_path = fnamemodify(a:filepath, ':p')
  let l:cwd = getcwd()
  let l:rel_path = substitute(l:absolute_path, '^' . l:cwd . '/', '', '')

  return l:rel_path
endfunction

command! -bar MakeTestFileLine call MakeTestFileLine()
command! -bar MakeTestFile     call MakeTestFile()
command! -bar MakeTestBottom   call MakeTestBottom()
command! -bar MakeTestRight    call MakeTestRight()
command! -bar MakeTestAsTab    call MakeTestAsTab()
