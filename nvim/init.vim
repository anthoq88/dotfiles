" TODO follow sym links
call plug#begin()
Plug 'tpope/vim-sensible'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'scrooloose/nerdcommenter'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'benekastah/neomake'
Plug 'flazz/vim-colorschemes'
Plug 'guns/vim-sexp'
Plug 'osyo-manga/vim-over'
Plug 'bling/vim-airline'
Plug 'wikitopian/hardmode'
call plug#end()

exec 'set rtp+=' . fnamemodify(resolve(expand('~/.config/nvim/init.vim')), ':h')

" TODO better clojure syntax highlighting
colorscheme Tomorrow-Night

set nu
set nowrap
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4
set nohlsearch
set smartcase
set cursorline
set relativenumber

inoremap jk <Esc>

let mapleader = "\<Space>"

syntax on
filetype plugin indent on

"stay selected when visual mode indenting
vmap < <gv
vmap > >gv

"tabs
nnoremap <C-w>t :tabe<CR>
nnoremap <C-w>C :tabc<CR>
nnoremap <C-w>\> gt
nnoremap <C-w>\< gT

"Set current buffer to directory
nnoremap <leader>vd :cd %:p:h<CR>

" Apply file
nnoremap <leader>vr :so %<CR>

noremap <leader>; :call NERDComment(1, 'toggle')<CR>

nnoremap <leader>o <C-^>
nnoremap <leader>d :Explore<CR>
nnoremap <leader>: :OverCommandLine<CR>

let g:airline_powerline_fonts=1 " TODO move to airline file
"call HardMode()

autocmd! BufEnter * silent! lcd %:p:h

au WinLeave * set norelativenumber
au FocusLost * set norelativenumber

au WinEnter * set relativenumber
au FocusGained * set relativenumber

nnoremap <leader>n :set relativenumber!<CR>

runtime fzf.vim
runtime fugitive.vim
runtime neomake.vim
runtime netrw.vim
runtime clojure.vim
runtime surround.vim

