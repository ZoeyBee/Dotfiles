"" vundle
set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim/
call vundle#begin()
    
" VIM plugins
Plugin 'VundleVim/Vundle.vim'
Plugin 'tpope/vim-surround'

call vundle#end()

filetype plugin indent on

" Leader
let mapleader=","

" colourscheme
syntax on
set nofoldenable
set t_Co=256

" set working directory to current file's directory
set autochdir

" tab settings
set tabstop=4
set shiftwidth=4
set expandtab

" bracket autocompletion
inoremap " ""<left>
inoremap ' ''<left>
inoremap ( ()<left>
inoremap [ []<left>
inoremap { {}<left>
inoremap {<CR> {<CR>}<ESC>O

" Use ctrl-[hjkl] to select the active split!
nmap <silent> <c-k> :wincmd k<CR>
nmap <silent> <c-j> :wincmd j<CR>
nmap <silent> <c-h> :wincmd h<CR>
nmap <silent> <c-l> :wincmd l<CR>]"

" autoindent inside of bracket
:set autoindent
:set cindent

" using bc to calculate
nmap <Leader>c :r ! echo "" \| bc 6<Left>

" rendering with <leader>l
autocmd FileType markdown nmap <Leader>l :w<ENTER> :! pandoc -o <c-R>%<BS><BS>pdf --template assignment <c-R>%<ENTER><ENTER>
autocmd FileType python nmap <Leader>l :w<ENTER> :! python3 <c-R>%<ENTER>
autocmd FileType tex nmap <Leader>l :w<ENTER> :! pdflatex <c-R>%<ENTER><ENTER>

xmap ' S'
xmap ( S)
xmap [ S]
xmap { S}

nnoremap q: :q

" Prefrences
set noswapfile
set nohlsearch

" Emacs binds
nmap <Leader>q :q!<ENTER>
nmap <Leader>k :q!<ENTER>
nmap <Leader>s :w<ENTER>