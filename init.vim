call plug#begin()
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'neoclide/coc.nvim', {'do': 'yarn install --frozen-lockfile'}
Plug 'editorconfig/editorconfig-vim'
Plug 'vim-airline/vim-airline'
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
call plug#end()

colorscheme dracula

set hidden
set number
set mouse=a
set inccommand=split
set colorcolumn=80,120

set completeopt=noinsert,menuone,noselect

let g:coc_node_path = '/home/daniel/.asdf/installs/nodejs/12.16.2/bin/node'

let g:coc_global_extensions = [
      \'coc-eslint',
      \'coc-tsserver',
      \'coc-prettier',
      \'coc-elixir',
      \'coc-json',
      \'coc-pairs'
      \]

let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize = 25

nnoremap <F1> :NERDTreeToggle<CR>
