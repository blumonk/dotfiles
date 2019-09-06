filetype off

" Set runtime path to vundle
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" List of plugins 
Plugin 'gmarik/Vundle.vim'
"Plugin 'w0rp/ale'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/nerdcommenter'
Plugin 'Raimondi/delimitMate'
Plugin 'nanotech/jellybeans.vim'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'Valloric/MatchTagAlways'
Plugin 'hashivim/vim-vagrant'
Plugin 'davidhalter/jedi-vim'
Plugin 'dag/vim-fish'
Plugin 'fatih/vim-go'
Plugin 'SirVer/ultisnips'

call vundle#end()

filetype plugin indent on

syntax on                   " Show syntax highlighting
set encoding=utf-8          " Default encoding UTF-8
set nocompatible            " Just in case
set number                  " Show absolute line numbers
set showmatch               " Highlight bracket matches
set ruler                   " Show line and column on footer
set scrolloff=15            " Minimum lines above and below the cursor
set t_Co=256                " Enable 256 colors
set wildmenu                " Bash-style auto completion
set cursorline              " Highlight the current line
set laststatus=2            " Always show the status bar
set ignorecase              " Always ignore case when searching
set noswapfile              " Don't need the swap file
set clipboard=unnamedplus
colorscheme jellybeans      " Set the color scheme

let g:jedi#completions_command = "<C-N>"

let g:NERDTreeNodeDelimiter = "\u00a0"

" Format python code with google/yapf
autocmd FileType python nnoremap <LocalLeader>= :0,$!yapf --style pep8<CR>

" Highlight Salt files
autocmd BufNewFile,BufRead *.sls set syntax=yaml

" Browse opened buffers easily
:nnoremap <F5> :buffers<CR>:buffer<Space>

" Automatically remove all trailing whitespaces
autocmd BufWritePre *.py :%s/\s\+$//e

" Airline config
let g:airline_theme='bubblegum'
let g:airline_powerline_fonts=1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_buffers = 1
let g:airline#extensions#tabline#fnamecollapse = 1
let g:airline#extensions#tabline#left_sep = ''
let g:airline#extensions#tabline#left_alt_sep = ''
let g:airline#extensions#tabline#right_sep = ''
let g:airline#extensions#tabline#right_alt_sep = ''
let g:airline#extensions#tabline#keymap_ignored_filetypes = ['nerdtree']

if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

" Enable folding by indent
set foldmethod=indent
set foldlevel=99
nnoremap <space> za

" Enable '.' in visual mode
vnoremap . :norm.<CR> 

" Assign leader keys
let mapleader = "\<Space>"
let maplocalleader = "-"

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
silent! nmap <leader>t :NERDTreeToggle<CR>

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

" Copy lines to clipboard in visual mode
vmap <C-c> :w !pbcopy<CR><CR>

" Go bindings
autocmd FileType go nmap <leader>d  <Plug>(go-def)

" Set ultisnips shortcuts
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

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
