call plug#begin()
" Plug 'vim-scripts/repeatable-motions.vim'
Plug 'pearofducks/ansible-vim'
" Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'lark-parser/vim-lark-syntax'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'morhetz/gruvbox'
Plug 'elixir-editors/vim-elixir'
call plug#end()

" colours
if (has('termguicolors'))
  set termguicolors
endif

autocmd vimenter * colorscheme gruvbox

syntax on
filetype plugin indent on

" make dollar sign a word character
set isk+=$

" make the enter and backspace keys work in normal mode
nnoremap <CR> i<CR><ESC>
nnoremap <BS> i<BS><Right><ESC>
nnoremap <DEL> a<DEL><ESC>
nnoremap <Space> a <Space><ESC>

" line numbering - relative in normal mode
set number
autocmd InsertEnter * :set norelativenumber
autocmd InsertLeave * :set relativenumber

" highlight the current line
set cursorline

" disable status line
set laststatus=0

" shift+enter opens a new line backwards
nnoremap <S-CR> <ESC>O
inoremap <S-CR> <ESC>O

" Ctrl+I and Ctrl+A to insert/append a single character
nnoremap <C-a> a <ESC>r
nnoremap <C-i> i <ESC>r

" alt+w to select inside this word
nnoremap <M-w> viw

" make ~ an operator, not act on a single character
set tildeop

" change Y to yank til the end of the line like D and C, not the whole line
nnoremap Y y$

" change d et al. to use the black hole register
nnoremap d "_d
nnoremap D "_D
nnoremap c "_c
nnoremap C "_C
nnoremap x "_x
nnoremap X "_X
nnoremap s "_s
nnoremap S "_S
" add Alt for normal behaviour
nnoremap <M-d> d
nnoremap <M-D> D
nnoremap <M-c> c
nnoremap <M-C> C
nnoremap <M-x> x
nnoremap <M-X> X
nnoremap <M-s> s
nnoremap <M-S> S
" m as alias
nnoremap m d
nnoremap M D
" but don't lose behaviour of m/M
nnoremap <C-m> m
nnoremap <M-m> M

set tabstop=4 shiftwidth=4 expandtab softtabstop=4
autocmd filetype yaml set tabstop=2 shiftwidth=2
