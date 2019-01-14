call plug#begin('~/.local/share/nvim/plugged')
" Plugins
Plug 'ervandew/supertab'
Plug 'nvie/vim-flake8'
Plug 'Shougo/vimproc.vim', {'do' : 'make'}
Plug 'Chiel92/vim-autoformat'
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/nerdcommenter'
Plug 'airblade/vim-gitgutter'
Plug 'JamshedVesuna/vim-markdown-preview'
Plug 'heavenshell/vim-pydocstring'
" Plug 'Valloric/YouCompleteMe'
Plug 'vim-scripts/cmdalias.vim'
" Plug 'alvan/vim-closetag'
Plug 'Quramy/tsuquyomi'
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'
Plug 'w0rp/ale'
Plug 'vim-airline/vim-airline'
Plug 'RRethy/vim-illuminate'
Plug 'luochen1990/rainbow'
Plug 'inside/vim-search-pulse'
Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins'}
Plug 'davidhalter/jedi-vim', {'for': 'python'}
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
call plug#end()


let g:vim_markdown_folding_disabled = 1
let g:python3_host_prog='/usr/bin/python3'
let g:python_host_prog='/usr/bin/python2'

" Enable rainbow at startup
let g:rainbow_active = 1

" More contrast
hi link illuminatedWord Visual

" For ale linting
let g:ale_linters = {
\   'python': ['vulture', 'yapf', 'flake8'],
\}

" Ale linting with airline
let g:airline#extensions#ale#enabled = 1

" Only run linters named in ale_linters settings.
let g:ale_linters_explicit = 1

" Run yapf on <leader>y
noremap <leader>y :Autoformat<CR>
" autocmd FileType python nnoremap <leader>y :1>,$!yapf<Cr><C-o>

" TsuDefinition TsuRenameSymbol TsuReferences

autocmd FileType typescript nmap <buffer> <Leader>r <Plug>(TsuquyomiRenameSymbol)
autocmd FileType typescript nmap <buffer> <Leader>R <Plug>(TsuquyomiRenameSymbolC)
autocmd FileType typescript nmap <silent> <leader>g <Plug>(TsuquyomiDefinition)
autocmd FileType typescript nmap <silent> <leader>n <Plug>(TsuquyomiReferences)

autocmd FileType python let g:jedi#completions_command = "<c-x><c-o>"
autocmd FileType python let g:jedi#completions_enabled = 1
" let g:jedi#rename_command = "<leader>r"
autocmd FileType python nmap <silent> <leader>rr :Semshi rename<CR>
" Using <C-Space> for omnicompletion
autocmd FileType python inoremap <silent> <buffer> <C-Space> <c-x><c-o>

" For Python AutoPEP8 and Jedi code completion
let g:autopep8_disable_show_diff=0
let g:autopep8_on_save=0
let g:PyFlakeOnWrite = 0
let g:jedi#popup_on_dot = 0
let g:jedi#show_call_signatures = "2"
let g:jedi#use_splits_not_buffers = "left"
" let g:jedi#use_tabs_not_buffers = 1
let g:jedi#goto_command = "<leader>d"
let g:jedi#goto_assignments_command = "<leader>g"
let g:jedi#goto_definitions_command = ""
let g:jedi#documentation_command = "K"
let g:jedi#usages_command = "<leader>n"

let g:tsuquyomi_completion_detail = 1

" For ALE
nmap <silent> <leader>aj :ALENext<cr>
nmap <silent> <leader>ak :ALEPrevious<cr>

" For YouCompleteMe
let g:ycm_auto_trigger = 0
let g:ycm_filetype_specific_completion_to_disable = {
      \ 'python': 1
      \}

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
autocmd FileType pyhon set omnifunc=jedi#completions


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


" Leader + up/down key moves lines
nnoremap <leader><Up>   :<C-u>silent! move-2<CR>==
nnoremap <leader><Down> :<C-u>silent! move+<CR>==
xnoremap <leader><Up>   :<C-u>silent! '<,'>move-2<CR>gv=gv
xnoremap <leader><Down> :<C-u>silent! '<,'>move'>+<CR>gv=gv
nnoremap <esc><esc> :silent! nohls<cr>

" Go to tab by number
noremap <leader>1 1gt
noremap <leader>2 2gt
noremap <leader>3 3gt
noremap <leader>4 4gt
noremap <leader>5 5gt
noremap <leader>6 6gt
noremap <leader>7 7gt
noremap <leader>8 8gt
noremap <leader>9 9gt
noremap <leader>0 :tablast<cr>

" Use industry theme
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

" Use spaces for HTML files
autocmd BufRead *.html :call UseSpaces()

" Reload semshi because it seems to only work for me after a restart...
autocmd VimEnter *.py :call plug#end()


" UseSpaces() by default
call UseSpaces()
" call UseTabs()

" For file type detection
filetype plugin on
filetype plugin indent on
