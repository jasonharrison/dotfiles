execute pathogen#infect()
call pathogen#helptags()
call plug#begin('~/.vim/plugged')

" Plugins
Plug 'sheerun/vim-polyglot'
Plug 'davidhalter/jedi-vim'
Plug 'nvie/vim-flake8'
Plug 'Shougo/vimproc.vim', {'do' : 'make'}
Plug 'Quramy/tsuquyomi'
Plug 'jason0x43/vim-js-indent'
Plug 'leafgarland/typescript-vim'
Plug 'Chiel92/vim-autoformat'
Plug 'scrooloose/nerdcommenter'
Plug 'airblade/vim-gitgutter'

call plug#end()

" For auto Flake8 on save
"autocmd BufWritePost *.py call Flake8()

let g:autopep8_disable_show_diff=1
let g:autopep8_on_save=1
let g:PyFlakeOnWrite = 0
let g:jedi#popup_on_dot = 0
let g:jedi#show_call_signatures = 0

" Always show line numbers
set number

" Case sensitive searching
set noignorecase

" Mouse input
set mouse=a
set ttymouse=xterm2

" Use F5 key for Flake8
autocmd FileType python map <buffer> <F5> :call Flake8()<CR>

" For local replace
nnoremap gr gd[{V%::s/<C-R>///gc<left><left><left>

" For global replace
nnoremap gR gD:%s/<C-R>///gc<left><left><left>

function! UseTabs()
  set tabstop=4     " Size of a hard tabstop (ts).
  set shiftwidth=4  " Size of an indentation (sw).
  set noexpandtab   " Always uses tabs instead of space characters (noet).
  set autoindent    " Copy indent from current line when starting a new line (ai).
endfunction

function! UseSpaces()
  set tabstop=2     " Size of a hard tabstop (ts).
  set shiftwidth=2  " Size of an indentation (sw).
  set expandtab     " Always uses spaces instead of tab characters (et).
  set softtabstop=0 " Number of spaces a <Tab> counts for. When 0, featuer is off (sts).
  set autoindent    " Copy indent from current line when starting a new line.
  set smarttab      " Inserts blanks on a <Tab> key (as per sw, ts and sts).
endfunction

" UseSpaces() by default
call UseSpaces()

" For file type detection
filetype plugin on

" Shift key + arrow key to move lines
nnoremap <S-Up> :m-2<CR>
nnoremap <S-Down> :m+<CR>
inoremap <S-Up> <Esc>:m-2<CR>
inoremap <S-Down> <Esc>:m+<CR>

" For gvim
if has('gui_running')
  colorscheme industry
endif

nnoremap yy yy"+yy
vnoremap y ygv"+y

" For :DIFF 
function! s:diff()
    let tmpa = tempname()
    let tmpb = tempname()
    earlier 100h
    exec 'w '.tmpa
    later 100h
    exec 'w '.tmpb
    update
    exec 'tabnew '.tmpa
    diffthis
    vert split
    exec 'edit '.tmpb
    diffthis
endfunction
command! -nargs=0 DIFF call <SID>diff()

" Always show tab names
set showtabline=2
