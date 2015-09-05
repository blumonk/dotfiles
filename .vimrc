filetype off

" Set runtime path to vundle
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" List of plugins 
Plugin 'gmarik/Vundle.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/syntastic'
Plugin 'Raimondi/delimitMate'
Plugin 'nanotech/jellybeans.vim'
Plugin 'SirVer/ultisnips'
Plugin 'honza/vim-snippets'

call vundle#end()
filetype plugin indent on

syntax on                  " Show syntax highlighting
set nocompatible           " Just in case
set number                 " Show absolute line numbers
set showmatch              " Highlight bracket matches 
set ruler                  " Show line and column on footer
set scrolloff=15           " Minimum lines above and below the cursor
set t_Co=256               " Enable 256 colors
set wildmenu               " Bash-style auto completion
set cursorline             " Highlight the current line
set laststatus=2           " Always show the status bar
set smartcase              " Ignore case if pattern is all lowercase
colorscheme jellybeans     " Set the color scheme

" Configure indents
set autoindent
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4

" Remember more commands and search history
set history=1000
set undolevels=1000

" Let backspacing in insert mode
set backspace=indent,eol,start

" Search configs
set hlsearch
set incsearch

" Fast way to leave insert mode 
imap jk <ESC>

" Faster command mode
nnoremap ; :

" Paste toggle
set pastetoggle=<F3>

" NERDTree configs
silent! map <F2> :NERDTreeToggle<CR>

" Map ctrl-movement keys to window switching
map <C-k> <C-w><Up>
map <C-j> <C-w><Down>
map <C-l> <C-w><Right>
map <C-h> <C-w><Left>

" Browser-like switching between buffers
nnoremap <C-Tab> :bnext<cr>
nnoremap <C-S-Tab> :bprevious<cr>

" Highlight the status bar when in insert mode
if version >= 700
	au InsertEnter * hi StatusLine ctermfg=235 ctermbg=85	 
	au InsertLeave * hi StatusLine ctermfg=235 ctermbg=131 
endif
