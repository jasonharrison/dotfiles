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
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/nerdcommenter'
Plug 'airblade/vim-gitgutter'
Plug 'JamshedVesuna/vim-markdown-preview'
Plug 'heavenshell/vim-pydocstring'
Plug 'Valloric/YouCompleteMe'
Plug 'vim-scripts/cmdalias.vim'
Plug 'tpope/vim-pathogen'

call plug#end()

execute pathogen#infect()
call pathogen#helptags()
let g:python3_host_prog='/usr/bin/python3'
let g:python_host_prog='/usr/bin/python2'
" For auto Flake8 on save
"autocmd BufWritePost *.py call Flake8()

" For Python AutoPEP8 and Jedi code completion
let g:autopep8_disable_show_diff=0
let g:autopep8_on_save=0
let g:PyFlakeOnWrite = 0
let g:jedi#popup_on_dot = 0
let g:jedi#show_call_signatures = 0
let g:jedi#use_splits_not_buffers = "left"
let g:jedi#goto_command = "<leader>d"
let g:jedi#goto_assignments_command = "<leader>g"
let g:jedi#goto_definitions_command = ""
let g:jedi#documentation_command = "K"
let g:jedi#usages_command = "<leader>n"
let g:jedi#completions_command = "<C-Space>"
let g:jedi#rename_command = "<leader>r"

" For YouCompleteMe
let g:ycm_auto_trigger = 0

" For vim-markdown-preview
let vim_markdown_preview_github=1 

" Always show line numbers
set number

" Case sensitive searching
set noignorecase

" Mouse input
set mouse=a

" Use leader (usually \) + f for Flake8
autocmd FileType python map <buffer> <Leader>f :call Flake8()<CR>


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
call UseTabs()

" For file type detection
filetype plugin on

" Shift key + arrow key to move lines
nnoremap <F6> :m-2<CR>
nnoremap <F5> :m+<CR>
inoremap <F6> <Esc>:m-2<CR>
inoremap <F5> <Esc>:m+<CR>
nnoremap <esc><esc> :silent! nohls<cr>

autocmd VimEnter * colorscheme industry 
" colorscheme darkblue
" colorscheme slate
" colorscheme elflord

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

" Leader (usually backslash) s is autoreplace
:nnoremap <Leader>s :%s/\<<C-r><C-w>\>/

" Alias :tabclose to :tac
autocmd VimEnter * Alias tac tabclose
