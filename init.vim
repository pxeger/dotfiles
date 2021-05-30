" leader space
let mapleader = " "

call plug#begin()
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'lark-parser/vim-lark-syntax'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'morhetz/gruvbox'
Plug 'jiangmiao/auto-pairs'
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'
Plug 'hashivim/vim-terraform'
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

" keep cursor away from edge of screen
set scrolloff=6

nnoremap <Leader><Space> :w<CR>

nnoremap <Leader><ESC> :noh<CR>

" Ctrl+I and Ctrl+A to insert/append a single character
nnoremap <C-a> a <ESC>r
nnoremap <C-i> i <ESC>r
" alt for doing that at the start/end of lines
nnoremap <M-a> A <ESC>r
nnoremap <M-i> I <ESC>r

" Ctrl+O opens a new line without editing it
nnoremap <C-o> o<ESC>k

" alt+w to select inside this word
nnoremap <M-w> viw

" utilities for registers:
" system clipboard
nnoremap £ "+
vnoremap £ "+
" alternative register
nnoremap ¬ "a

" make ~ an operator, not act on a single character
set tildeop

" jump to last position when reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

" git's 'intent to add' feature
nnoremap <Leader>N :w<CR>:!git add -N %<CR>

" merge line with previous
nnoremap <Leader><BS> ^d0i<BS> <ESC>

" make Y/S more consistent
nnoremap Y y$
nnoremap S Xi

" delete right
nnoremap <C-X> l"axh
nnoremap <C-S> l"ash

" make c/x/s use the a register rather than default
nnoremap c "ac
nnoremap C "aC
nnoremap x "ax
nnoremap X "aX
nnoremap s "as
nnoremap S "aXi
nnoremap <M-d> "_d
nnoremap <M-D> "_D

" make jk travel through soft-wrapped lines
nnoremap j gj
nnoremap k gk
nnoremap gj j
nnoremap gk k

" force myself to use hjkl
nnoremap <Left> <nop>
nnoremap <Right> <nop>
nnoremap <Up> <nop>
nnoremap <Down> <nop>
nnoremap <C-left> <nop>
nnoremap <C-right> <nop>
inoremap <Left> <nop>
inoremap <Right> <nop>
inoremap <Up> <nop>
inoremap <Down> <nop>
inoremap <C-left> <nop>
inoremap <C-right> <nop>
onoremap <Left> <nop>
onoremap <Right> <nop>
onoremap <Up> <nop>
onoremap <Down> <nop>
onoremap <C-left> <nop>
onoremap <C-right> <nop>
vnoremap <Left> <nop>
vnoremap <Right> <nop>
vnoremap <Up> <nop>
vnoremap <Down> <nop>
vnoremap <C-left> <nop>
vnoremap <C-right> <nop>

set formatoptions-=l

set tabstop=4 shiftwidth=4 expandtab softtabstop=4
autocmd filetype yaml set tabstop=2 shiftwidth=2
autocmd filetype typescriptreact set tabstop=2 shiftwidth=2
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
