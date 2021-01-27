call plug#begin()
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'lark-parser/vim-lark-syntax'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'morhetz/gruvbox'
Plug 'jiangmiao/auto-pairs'
call plug#end()

" colours
if (has('termguicolors'))
  set termguicolors
endif

autocmd vimenter * colorscheme gruvbox

syntax on
filetype plugin indent on

nmap <silent>K <Plug>(lcn-hover)
nmap <silent> gd <Plug>(lcn-definition)
nmap <silent> <F2> <Plug>(lcn-rename)

" make dollar sign a word character
set isk+=$

" make the enter and backspace keys work in normal mode
nnoremap <CR> i<CR><ESC>
nnoremap <BS> i<BS><Right><ESC>
nnoremap <DEL> a<DEL><ESC>

" line numbering - relative in normal mode
set number
set relativenumber
augroup linenumbering
    autocmd!
    autocmd InsertEnter * :set norelativenumber
    autocmd InsertLeave * :set relativenumber
augroup END

" highlight the current line
set cursorline

" disable status line
set laststatus=0

" shift+enter opens a new line backwards
nnoremap <S-CR> <ESC>O

" Ctrl+I and Ctrl+A to insert/append a single character
nnoremap <C-a> a <ESC>r
nnoremap <C-i> i <ESC>r

" alt+w to select inside this word
nnoremap <M-w> viw

" make ~ an operator, not act on a single character
set tildeop

" change Y to yank til the end of the line like D and C, not the whole line
nnoremap Y y$

nnoremap c "_c
nnoremap C "_C
nnoremap x "_x
nnoremap X "_X
nnoremap s "_s
nnoremap S "_S
nnoremap <M-d> "_d
nnoremap <M-D> "_D
nnoremap <M-c> c
nnoremap <M-C> C
nnoremap <M-x> x
nnoremap <M-X> X
nnoremap <M-s> s
nnoremap <M-S> S

nnoremap j gj
nnoremap k gk
nnoremap gj j
nnoremap gk k

set formatoptions-=l

set tabstop=4 shiftwidth=4 expandtab softtabstop=4
autocmd filetype yaml set tabstop=2 shiftwidth=2
autocmd filetype markdown set textwidth=120

" trigger CoC completion with tab
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <Tab>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()
