filetype off

" Set runtime path to vundle
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" List of plugins 
Plugin 'gmarik/Vundle.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/syntastic'
Plugin 'scrooloose/nerdcommenter'
Plugin 'Raimondi/delimitMate'
Plugin 'nanotech/jellybeans.vim'
Plugin 'bling/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'Valloric/MatchTagAlways'

call vundle#end()

filetype plugin indent on

syntax on                  " Show syntax highlighting
set encoding=utf-8         " Default encoding UTF-8 
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
set noswapfile             " Don't need the swap file
colorscheme jellybeans     " Set the color scheme

" Syntastic config
let g:syntastic_python_checkers=['pyflakes']

" Executing code
autocmd FileType python nnoremap <silent> <F9> :w<cr>:exec '!clear;ipython3 -i %' shellescape(@%, 1)<cr>
autocmd FileType c,cpp  nnoremap <silent> <F9> :w<cr>:exec '!clear;make'<cr>

" Airline config
let g:airline_theme='bubblegum'
let g:airline_powerline_fonts=1
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

" Enable '.' in visual mode
vnoremap . :norm.<CR> 

" Remap the leader key to Space
let mapleader = "\<Space>"

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

" Delete previous word in insert mode
imap <C-BS> <C-W>

" Search configs
set hlsearch
set incsearch

" Fast way to leave insert mode 
imap jk <ESC>

" Paste toggle
set pastetoggle=<F10>

" Fast switching between buffers
nmap <C-n> :bnext<CR>
nmap <C-p> :bprevious<CR>

" NERDTree toggle
silent! nmap <F2> :NERDTreeToggle<CR>

" Intellij-like commenting
silent! nmap <C-c> :call NERDComment(0,"toggle")<CR>j

" Map ctrl-movement keys to window switching
map <C-k> <C-w><Up>
map <C-j> <C-w><Down>
map <C-l> <C-w><Right>
map <C-h> <C-w><Left>

" Browser-like switching between buffers
silent! nmap <C-Tab> :bnext
silent! nnoremap <C-S-Tab> :bprevious<cr>

" Automatically close NERDTree when quitting vim
function! NERDTreeQuit()
  redir => buffersoutput
  silent buffers
  redir END
  let pattern = '^\s*\(\d\+\)\(.....\) "\(.*\)"\s\+line \(\d\+\)$'
  let windowfound = 0

  for bline in split(buffersoutput, "\n")
    let m = matchlist(bline, pattern)

    if (len(m) > 0)
      if (m[2] =~ '..a..')
        let windowfound = 1
      endif
    endif
  endfor

  if (!windowfound)
    quitall
  endif
endfunction
autocmd WinEnter * call NERDTreeQuit()
