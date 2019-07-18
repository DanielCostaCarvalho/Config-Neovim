call plug#begin()
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'terryma/vim-multiple-cursors'
Plug 'sheerun/vim-polyglot'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'w0rp/ale'
Plug 'jiangmiao/auto-pairs'
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'jeetsukumaran/vim-buffergator'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'glippi/yarn-vim'
Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}
Plug 'editorconfig/editorconfig-vim'
Plug 'vim-airline/vim-airline'
call plug#end()

colorscheme dracula

set hidden
set number
set mouse=a
set inccommand=split
set autochdir
set colorcolumn=80,120

set completeopt=noinsert,menuone,noselect

let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'javascript': ['eslint'],
\}

let g:ale_fix_on_save = 1

let mapleader="\<space>"
nnoremap <leader>; A;<esc>
nnoremap <F1> :NERDTreeToggle<CR>
nnoremap <c-p> :Files<cr>
nnoremap <c-f> :Ag<space>
