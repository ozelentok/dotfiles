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
call dein#add('vim-airline/vim-airline')
call dein#add('vim-airline/vim-airline-themes')
call dein#add('scrooloose/nerdtree')
call dein#add('jistr/vim-nerdtree-tabs')
call dein#add('easymotion/vim-easymotion')
call dein#add('neomake/neomake')
call dein#add('scrooloose/nerdcommenter')
call dein#add('tpope/vim-surround')
call dein#add('tpope/vim-fugitive')
call dein#add('tpope/vim-abolish')
call dein#add('brooth/far.vim')
call dein#add('godlygeek/tabular')
call dein#add('ozelentok/vim-closer')
call dein#add('Shougo/denite.nvim')
call dein#add('ozelentok/denite-gtags')
call dein#add('Shougo/neosnippet')
call dein#add('Shougo/neosnippet-snippets')
call dein#add('Honza/vim-snippets')
call dein#add('Shougo/echodoc.vim')
call dein#add('Shougo/deoplete.nvim')
call dein#add('Shougo/neco-vim')
call dein#add('zchee/deoplete-jedi')
call dein#add('tweekmonster/deoplete-clang2')
call dein#add('ozelentok/deoplete-gtags')
call dein#add('carlitux/deoplete-ternjs') "Requires ternjs - install using npm
call dein#add('mhartington/nvim-typescript') "Requires typescript - install using npm
call dein#add('pangloss/vim-javascript')
call dein#add('leafgarland/typescript-vim')
call dein#add('ianks/vim-tsx')
call dein#add('mxw/vim-jsx')
call dein#add('Vimjas/vim-python-pep8-indent')
call dein#add('vim-python/python-syntax')
call dein#add('octol/vim-cpp-enhanced-highlight')
call dein#add('ap/vim-css-color')
call dein#end()
"General
filetype plugin indent on
syntax on
set backup
set showcmd
set hlsearch
set incsearch
set ignorecase
set inccommand=split
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
set backspace=indent,eol,start

"Colorscheme
set termguicolors
colors colosus
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
set clipboard=unnamed,unnamedplus

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

nnoremap <C-P><C-P> :DeniteProjectDir -no-empty -buffer-name=files file_rec<cr>
nnoremap <C-P><C-G> :DeniteProjectDir -no-empty -buffer-name=files-git file_rec/git<cr>
nnoremap <C-P><C-J> :Denite -no-empty -buffer-name=samename -input=`expand('%:t:r')` file_rec/git<cr>
nnoremap <leader>b :Denite -buffer-name=buffer buffer<cr>
nnoremap <leader>a :DeniteCursorWord -no-empty -buffer-name=gtags_c gtags_context<cr>
nnoremap <leader>d :DeniteCursorWord -no-empty -buffer-name=gtags_d gtags_def<cr>
nnoremap <leader>r :DeniteCursorWord -no-empty -buffer-name=gtags_r gtags_ref<cr>
nnoremap <leader>g :DeniteCursorWord -no-empty -buffer-name=gtags_g gtags_grep<cr>
nnoremap <leader>t :Denite -no-empty -buffer-name=gtags_t gtags_completion<cr>
nnoremap <leader>f :Denite -no-empty -buffer-name=gtags_f gtags_file<cr>
nnoremap <leader>p :Denite -no-empty -buffer-name=gtags_p gtags_path<cr>

call denite#custom#map('insert', '<C-j>', '<denite:move_to_next_line>', 'noremap')
call denite#custom#map('insert', '<C-k>', '<denite:move_to_previous_line>', 'noremap')
call denite#custom#map('insert', '<C-t>', '<denite:do_action:tabopen>', 'noremap')
call denite#custom#map('insert', '<C-s>', '<denite:do_action:split>', 'noremap')
call denite#custom#map('insert', '<C-v>', '<denite:do_action:vsplit>', 'noremap')
call denite#custom#alias('source', 'file_rec/git', 'file_rec')
call denite#custom#var('file_rec/git', 'command', ['git', 'ls-files', '-co', '--exclude-standard'])
call denite#custom#source('file_rec', 'sorters', ['sorter_sublime'])
call denite#custom#option('_', 'winheight', 10)

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
let g:airline_symbols.maxlinenr = ''
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
autocmd FileReadPre * silent! lcd %:p:h

" Autocomplete
"set omnifunc=syntaxcomplete#Complete
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html setlocal autoindent omnifunc=htmlcomplete#CompleteTags
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType java setlocal omnifunc=javacomplete#Complete

"Tabs to spaces
autocmd FileType python setlocal expandtab tabstop=4 shiftwidth=4
autocmd FileType typescript setlocal expandtab tabstop=4 shiftwidth=4

"Tags
set tags=tags;,/usr/include/tags

"GNU Global - "Gtags
set cscopetag
let GtagsCscope_Ignore_Case = 1
let GtagsCscope_Absolute_Path = 1
autocmd BufReadPost * silent GtagsCscope
autocmd BufWritePost * GtagsUpdate

"Neomake
call neomake#configure#automake('rw', 0)
let g:neomake_open_list = 0
let g:neomake_list_height = 6

"Neomake Makers
let g:neomake_python_enabled_makers = ['python', 'pycodestyle', 'mypy']

"Language Syntax
let g:python_highlight_all = 1
let g:jsx_ext_required = 0

"Deoplete
let g:deoplete#enable_at_startup = 1
call deoplete#custom#set('_', 'min_pattern_length', 0)
autocmd InsertLeave,CompleteDone * pclose!

"Deoplete Clang2
let g:clang2_placeholder_next = ''

"Deoplete jedi
let g:deoplete#sources#jedi#show_docstring = 1

"Echodoc
set cmdheight=2
let g:echodoc_enable_at_startup = 1

"Neosnippets
imap <expr><tab> neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<tab>"
smap <expr><tab> neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<tab>"
let g:neosnippet#enable_snipmate_compatibility = 1
