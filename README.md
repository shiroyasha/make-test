# Make Test for Vim

Executes your test with `make test FILE=<file>:<line>`.

Installation:

``` vim
Plug 'shiroyasha/make-test'
```

Configuration:

``` vim
" make-test

nmap <silent> <leader>t :MakeTestFileLine<CR>
nmap <silent> <leader>T :MakeTestFile<CR>
```

With the above configuration:

- `Leader+t` executes `make test FILE=<file>:<line>`
- `Leader+T` executes `make test FILE=<file>`
