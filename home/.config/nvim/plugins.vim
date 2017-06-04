function! DoRemote(arg)
  UpdateRemotePlugins
endfunction

call plug#begin()
Plug 'flazz/vim-colorschemes'
Plug 'neovim/node-host'
Plug 'tpope/vim-sensible'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'scrooloose/nerdcommenter'
Plug 'tpope/vim-surround'
Plug 'benekastah/neomake'
Plug 'itchyny/lightline.vim'
Plug 'justinmk/vim-sneak'
Plug 'mattn/emmet-vim'
Plug 'guns/vim-sexp'
Plug 'Shougo/vimproc.vim', { 'do': 'make' }
Plug 'Shougo/deoplete.nvim', { 'do': function('DoRemote') }
Plug 'neovimhaskell/haskell-vim'
Plug 'raichoo/purescript-vim'
Plug 'avakhov/vim-yaml'
Plug 'luisjure/csound'
Plug 'FrigoEU/psc-ide-vim'
Plug 'ndmitchell/ghcid', { 'rtp': 'plugins/nvim' }
Plug 'mbbill/undotree'
"Plug 'kovisoft/paredit'
Plug 'kovisoft/slimv'
Plug 'wlangstroth/vim-racket'
Plug 'JuliaEditorSupport/julia-vim'
Plug 'luochen1990/rainbow'
Plug 'aqui8/agda-vim'
Plug 'tpope/vim-vinegar'
Plug 'tikhomirov/vim-glsl'
Plug 'alx741/vim-hindent'
Plug 'eagletmt/neco-ghc'
"TODO Ripgrep
call plug#end()
