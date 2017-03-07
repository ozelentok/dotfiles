set nocompatible
if has('win32') || has('win64')
	let b:os='Windows'
	let b:vim_files=$HOME . '/.config/nvim'
	let b:dein_dir=b:vim_files . '/dein'
	let &rtp.=',' . b:dein_dir . '/repos/github.com/Shougo/dein.vim'
	set directory=C:\temp
	set backupdir=C:\temp
	" Vim with 256 colors inside ConEmu
	if !has("gui_running")
		set term=xterm
		set t_Co=256
		let &t_AB="\e[48;5;%dm"
		let &t_AF="\e[38;5;%dm"
	endif
else
	let b:os='Linux'
	let b:vim_files=$HOME . '/.config/nvim'
	let b:dein_dir=b:vim_files . '/dein'
	let &rtp.=',' . b:dein_dir . '/repos/github.com/Shougo/dein.vim'
	set directory=/tmp
	set backupdir=/tmp
	set dictionary=/usr/share/dict/words
endif

call dein#begin(expand(b:dein_dir))
call dein#add('Shougo/dein.vim')
call dein#add('scrooloose/nerdtree')
call dein#add('neomake/neomake')
call dein#add('scrooloose/nerdcommenter')
call dein#add('tpope/vim-surround')
call dein#add('tpope/vim-fugitive')
call dein#add('easymotion/vim-easymotion')
call dein#add('vim-airline/vim-airline')
call dein#add('vim-airline/vim-airline-themes')
call dein#add('Shougo/unite.vim')
call dein#add('hewes/unite-gtags')
call dein#add('Shougo/deoplete.nvim')
call dein#add('Shougo/neosnippet')
call dein#add('Shougo/neosnippet-snippets')
call dein#add('Shougo/echodoc.vim')
"Plugin 'Valloric/YouCompleteMe'
call dein#add('jistr/vim-nerdtree-tabs')
call dein#add('rstacruz/vim-closer')
"call dein#add('davidhalter/jedi-vim')
call dein#add('zchee/deoplete-jedi')
"Requires libclang-py3 - install using pip
call dein#add('zchee/deoplete-clang')
call dein#add('Shougo/neoinclude.vim')
"call dein#add('vim-scripts/OmniCppComplete')
"call dein#add('vim-scripts/cscope_macros.vim')
call dein#add('octol/vim-cpp-enhanced-highlight')
"Requires ternjs - install using npm
call dein#add('carlitux/deoplete-ternjs')
"Requires typescript - install using npm 
call dein#add('mhartington/deoplete-typescript')
call dein#add('pangloss/vim-javascript')
call dein#add('mxw/vim-jsx')
call dein#add('leafgarland/typescript-vim')
call dein#add('godlygeek/tabular')
call dein#end()
"General
filetype plugin indent on
syntax on
set backup
set showcmd
set hlsearch
set incsearch
set ignorecase
set wildmenu
set wildmode=full
set wildignore=*.swp,.bak,*.pyc,*.class,*.o,*.obj
set wildignorecase
set autoindent
set number
set shiftwidth=2
set tabstop=2
set noexpandtab
set mouse=a
set laststatus=2
set encoding=utf-8
set spellsuggest=best,10
set textwidth=0
set autochdir
set backspace=indent,eol,start

"Colorscheme
colors colosus
hi Normal ctermbg=none
command! W w
let mapleader = ","
" map c-h/j/k/l to move between windows
nmap <c-h> <c-w>h
nmap <c-j> <c-w>j
nmap <c-k> <c-w>k
nmap <c-l> <c-w>l
" Navigation
noremap <space> 20j
vnoremap <space> 20j
noremap - 20k
vnoremap - 20k
"Resize
nnoremap _ <c-w>-
nnoremap + <c-w>+
nnoremap > <c-w>>
nnoremap < <c-w><

" Replicate yank/paste operations to system clipbaord
set clipboard=unnamed

" Go Back in tabs
noremap tp :tabp<cr>

" Date Insert
nnoremap <F3> "=strftime('%Y-%m-%d')<CR>P
inoremap <F3> <C-R>=strftime('%Y-%m-%d')<CR>
nnoremap <F4> "=strftime('%Y-%m-%d %H:%M:%S')<CR>P
inoremap <F4> <C-R>=strftime('%Y-%m-%d %H:%M:%S')<CR>

" From https://github.com/skwp/dotfiles/blob/master/vim/plugin/settings/stop-visual-paste-insanity.vim:
" If you visually select something and hit paste
" that thing gets yanked into your buffer. This
" generally is annoying when you're copying one item
" and repeatedly pasting it. This changes the paste
" command in visual mode so that it doesn't overwrite
" whatever is in your paste buffer.
vnoremap p "_dP
map <Leader>" ysiw"

"Unite
let g:unite_source_history_yank_enable = 1
let g:unite_enable_auto_select = 0
call unite#filters#matcher_default#use(['matcher_glob'])
"Like ctrlp.vim settings.
call unite#custom#profile('default', 'context', {
\   'start_insert': 1,
\   'winheight': 10,
\   'direction': 'botright',
\ })
nnoremap <C-P> :<C-u>Unite -buffer-name=files file_rec/neovim:!<cr>
nnoremap <leader>b :<C-u>Unite -buffer-name=buffer buffer<cr>
nnoremap <leader>s :<C-u>Unite -buffer-name=gtags-s gtags/context<cr>
nnoremap <leader>d :<C-u>Unite -buffer-name=gtags-d gtags/def<cr>
nnoremap <leader>r :<C-u>Unite -buffer-name=gtags-r gtags/ref<cr>
nnoremap <leader>g :<C-u>Unite -buffer-name=gtags-g gtags/grep<cr>
nnoremap <leader>t :<C-u>Unite -buffer-name=gtags-t gtags/completion<cr>
nnoremap <leader>f :<C-u>Unite -buffer-name=gtags-f gtags/file<cr>

autocmd FileType unite call s:unite_settings()
function! s:unite_settings()
  imap <buffer> <C-j>   <Plug>(unite_select_next_line)
  imap <buffer> <C-k>   <Plug>(unite_select_previous_line)
	autocmd InsertLeave <buffer> :UniteClose
endfunction

"Airline
if !exists('g:airline_symbols')
	let g:airline_symbols = {}
endif
let g:airline_left_sep = '⮀'
let g:airline_left_alt_sep = '⮁'
let g:airline_right_sep = '⮂'
let g:airline_right_alt_sep = '⮃'
let g:airline_symbols.branch = '⭠'
let g:airline_symbols.linenr = '⭡'
let g:airline_symbols.readonly = '⭤'
let g:airline_theme='powerlineish'
let g:airline#extensions#whitespace#enabled = 1

"NERDTree Window Toogle
noremap <Leader>nt :NERDTreeTabsToggle<cr>
let g:nerdtree_tabs_open_on_gui_startup = 0

" FileType
autocmd BufRead,BufEnter *.js setlocal nocindent smartindent
autocmd BufRead,BufEnter *.vs setlocal filetype=c
autocmd BufRead,BufEnter *.fs setlocal filetype=c

" Autocomplete
"set omnifunc=syntaxcomplete#Complete
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html setlocal autoindent omnifunc=htmlcomplete#CompleteTags
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType java setlocal omnifunc=javacomplete#Complete

"Tabs to spaces
autocmd FileType python setlocal expandtab tabstop=4 shiftwidth=4
autocmd FileType typescript setlocal expandtab tabstop=4 shiftwidth=4

"Neomake
autocmd BufReadPost * silent GtagsCscope
autocmd BufWritePost * GtagsUpdate
autocmd BufEnter,BufWritePost * silent Neomake

"Tags
set tags=tags;,/usr/include/tags

"Deoplete
let g:deoplete#enable_at_startup = 1
autocmd InsertLeave,CompleteDone * pclose!

"Deoplete clang
let g:deoplete#sources#clang#libclang_path='/usr/lib/libclang.so'
let g:deoplete#sources#clang#clang_header='/usr/include/clang'

"Echodoc
set cmdheight=2
let g:echodoc_enable_at_startup = 1

"Deoplete jedi
let g:deoplete#sources#jedi#show_docstring = 1

"Neosnippets
imap <expr><tab> neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<tab>"
smap <expr><tab> neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<tab>"


"Neomake Javascript & JSX
" For neomake support, install the linters
" $ npm install -g eslint tslint
let g:jsx_ext_required = 0
let g:neomake_javascript_enabled_makers = ['eslint']
let g:neomake_typescript_enabled_makers = ['tslint']

"Gtags

set cscopetag
let GtagsCscope_Ignore_Case = 1
let GtagsCscope_Absolute_Path = 1

nmap <C-space>s :cs find s <C-R>=expand("<cword>")<CR><CR>
nmap <C-space>g :cs find g <C-R>=expand("<cword>")<CR><CR>
nmap <C-space>c :cs find c <C-R>=expand("<cword>")<CR><CR>
nmap <C-space>t :cs find t <C-R>=expand("<cword>")<CR><CR>
nmap <C-space>e :cs find e <C-R>=expand("<cword>")<CR><CR>
nmap <C-space>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
nmap <C-space>i :cs find i <C-R>=expand("<cfile>")<CR><CR>

nmap <C-space>ts :scs find s <C-R>=expand("<cword>")<CR><CR>
nmap <C-space>tg :scs find g <C-R>=expand("<cword>")<CR><CR>
nmap <C-space>tc :scs find c <C-R>=expand("<cword>")<CR><CR>
nmap <C-space>tt :scs find t <C-R>=expand("<cword>")<CR><CR>
nmap <C-space>te :scs find e <C-R>=expand("<cword>")<CR><CR>
nmap <C-space>tf :scs find f <C-R>=expand("<cfile>")<CR><CR>
nmap <C-space>ti :scs find i <C-R>=expand("<cfile>")<CR><CR>
