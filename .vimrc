" Automatically source vimrc on save.
autocmd! bufwritepost $MYVIMRC source $MYVIMRC

" Trim whitespace on save
autocmd BufWritePre * :%s/\s\+$//e

set clipboard=unnamed

" Install vim-plug if its not found
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

" Make sure you use single quotes

Plug 'sheerun/vim-polyglot'
Plug 'pangloss/vim-javascript'
Plug 'w0rp/ale'
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'
Plug 'terryma/vim-multiple-cursors'
Plug 'itchyny/lightline.vim'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-surround'
Plug 'scrooloose/nerdtree'
Plug 'airblade/vim-gitgutter'
Plug 'mattn/emmet-vim'

" Initialize plugin system
call plug#end()

" ale configuration
nmap <silent> [c <Plug>(ale_previous_wrap)
nmap <silent> ]c <Plug>(ale_next_wrap)
let g:ale_sign_error = '❌'
let g:ale_sign_warning = '⚠️'

" fzf
nnoremap <C-p> :Files<CR>
nnoremap <Leader>b :Buffers<CR>
nnoremap <Leader>h :History<CR>

" lightline
set laststatus=2

" NerdTree
map <C-o> :NERDTreeToggle<CR>

