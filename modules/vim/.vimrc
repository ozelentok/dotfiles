set nocompatible
filetype plugin indent on

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
Bundle 'gmarkik/vundle'
Bundle 'scroloose/nerdtree'
Bundle 'Lokaltog/vim-powerline'
Bundle 'kien/ctrlp.vim'
Bundle 'sickill/vim-monokai'

set directory=.,$TEMP
source $VIMRUNTIME/vimrc_example.vim
syntax on
set wildmenu
set autoindent
set number
set shiftwidth=2
set tabstop=2
set guifont=Ubuntu\ Mono\ 13
set wildignorecase
colors Monokai
set laststatus=2   " Always show the statusline
set encoding=utf-8
let g:Powerline_symbols = 'unicode'
imap <f2> <c-o> ToggleHebrew() <cr>
map <f2> :call ToggleHebrew() <cr>
func! ToggleHebrew()
	if &rl
		set norl
		set keymap=
	else
		set rl
		set keymap=hebrew
	end
endfunc

" map c-h/j/k/l to move between windows
nmap <c-h> <c-w>h
nmap <c-j> <c-w>j
nmap <c-k> <c-w>k
nmap <c-l> <c-w>l

nmap <space> <pagedown>
nmap - <pageup>
nmap <backspace> <pageup>

" so :W will also save
command! W w

