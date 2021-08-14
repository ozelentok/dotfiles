set nocompatible

let g:vim_files=$HOME . '/.config/nvim'
let g:dein_dir=g:vim_files . '/dein'
let &rtp.=',' . g:dein_dir . '/repos/github.com/Shougo/dein.vim'

if !has('win32') && !has('win64')
	set directory=/tmp
	set backupdir=/tmp
	set undodir=/tmp
	set dictionary=/usr/share/dict/words
	let g:python3_host_prog = '/usr/bin/python3'
	let g:loaded_python_provider = 0 " Disable python2 provider
else
	set directory=C:\temp
	set backupdir=C:\temp
	set undodir=C:\temp
endif

if dein#load_state(expand(g:dein_dir))
	call dein#begin(expand(g:dein_dir))
	call dein#add('Shougo/dein.vim')
	call dein#add('vim-airline/vim-airline')
	call dein#add('vim-airline/vim-airline-themes')
	call dein#add('kyazdani42/nvim-web-devicons')
	call dein#add('kyazdani42/nvim-tree.lua')
	call dein#add('phaazon/hop.nvim')
	call dein#add('dense-analysis/ale')
	call dein#add('scrooloose/nerdcommenter')
	call dein#add('tpope/vim-surround')
	call dein#add('tpope/vim-fugitive')
	call dein#add('tpope/vim-abolish')
	call dein#add('brooth/far.vim')
	call dein#add('godlygeek/tabular')
	call dein#add('rstacruz/vim-closer')
	call dein#add('francoiscabrol/ranger.vim')
	call dein#add('sheerun/vim-polyglot')
	call dein#add('Shougo/denite.nvim')
	call dein#add('ozelentok/denite-gtags')
	call dein#add('Shougo/neomru.vim')
	call dein#add('Shougo/neosnippet')
	call dein#add('Shougo/neosnippet-snippets')
	call dein#add('Honza/vim-snippets')
	call dein#add('Shougo/echodoc.vim')
	call dein#add('Shougo/deoplete.nvim')
	call dein#add('Shougo/neco-vim')
	call dein#add('zchee/deoplete-clang')
	call dein#add('zchee/deoplete-jedi')
	call dein#add('ozelentok/deoplete-gtags')
	call dein#add('artur-shaik/vim-javacomplete2')
	call dein#add('mhartington/nvim-typescript', {'build': './install.sh'}) " Requires typescript - install using npm
	call dein#add('norcalli/nvim-colorizer.lua')
	call dein#add('iamcco/markdown-preview.nvim', {'build': 'sh -c "cd app && npm install"'}) " Requires npm
	call dein#add('lukas-reineke/indent-blankline.nvim')
	call dein#end()
	call dein#save_state()
endif

" General
filetype plugin indent on
syntax on
set backup
set showcmd
set hlsearch
set incsearch
set ignorecase
set inccommand=split
set signcolumn=yes
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
set autochdir
set undofile
set iskeyword+=\-
set nomodeline
set modelines=0

" Colorscheme
set termguicolors
colors colosus
command! W w
let mapleader=','
" Map c-h/j/k/l to move between windows
nmap <c-h> <c-w>h
nmap <c-j> <c-w>j
nmap <c-k> <c-w>k
nmap <c-l> <c-w>l
" Navigation
noremap <space> 20j
vnoremap <space> 20j
noremap - 20k
vnoremap - 20k
" Resize
nnoremap _ <c-w>-
nnoremap + <c-w>+
nnoremap > <c-w>>
nnoremap < <c-w><

" Replicate yank/paste operations to system clipbaord
set clipboard=unnamed,unnamedplus

" Go back in tabs
noremap tp :tabp<cr>

" Date Insert
nnoremap <F3> "=strftime('%Y-%m-%d')<CR>P
inoremap <F3> <C-R>=strftime('%Y-%m-%d')<CR>
nnoremap <F4> "=strftime('%Y-%m-%d %H:%M:%S')<CR>P
inoremap <F4> <C-R>=strftime('%Y-%m-%d %H:%M:%S')<CR>

" Disable visual block copy during paste
xnoremap <expr> p 'pgv"'.v:register.'y`>'
xnoremap <expr> P 'Pgv"'.v:register.'y`>'

" FileType
autocmd BufRead,BufEnter *.vs setlocal filetype=c
autocmd BufRead,BufEnter *.fs setlocal filetype=c
autocmd BufRead,BufEnter *.conf setlocal filetype=conf
autocmd FileReadPre * silent! lcd %:p:h

" Autocomplete
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html setlocal autoindent omnifunc=htmlcomplete#CompleteTags
autocmd FileType java setlocal omnifunc=javacomplete#Complete

" Language Specific Indention
autocmd FileType c setlocal expandtab tabstop=2 shiftwidth=2
autocmd FileType cpp setlocal expandtab tabstop=2 shiftwidth=2 cino=j1,(0,ws,Ws
autocmd FileType python setlocal expandtab tabstop=4 shiftwidth=4
autocmd FileType html setlocal expandtab tabstop=4 shiftwidth=4
autocmd FileType css setlocal expandtab tabstop=4 shiftwidth=4
autocmd FileType java setlocal expandtab tabstop=4 shiftwidth=4
autocmd FileType javascript setlocal expandtab tabstop=4 shiftwidth=4
autocmd FileType javascript.jsx setlocal expandtab tabstop=4 shiftwidth=4
autocmd FileType typescript setlocal expandtab tabstop=4 shiftwidth=4
autocmd FileType typescript.tsx setlocal expandtab tabstop=4 shiftwidth=4

" Tags
set tags=tags;,/usr/include/tags

" GNU Global (GTags)
set cscopetag
let GtagsCscope_Ignore_Case=1
let GtagsCscope_Absolute_Path=1
autocmd BufReadPost * silent GtagsCscope
autocmd BufWritePost * GtagsUpdate

" Denite
nnoremap <C-P><C-P> :DeniteProjectDir -no-empty -start-filter -buffer-name=files file/rec<cr>
nnoremap <C-P><C-G> :DeniteProjectDir -no-empty -start-filter -buffer-name=files-git file/rec/git<cr>
nnoremap <C-P><C-J> :DeniteProjectDir -no-empty -start-filter -buffer-name=samename -input=`expand('%:t:r')` file/rec/git<cr>
nnoremap <leader>b :Denite -buffer-name=buffer buffer<cr>
nnoremap <leader>m :Denite -buffer-name=mru file_mru<cr>
nnoremap <leader>a :DeniteCursorWord -path=`expand('%:p:h')` -no-empty -buffer-name=gtags_c gtags_context<cr>
nnoremap <leader>d :DeniteCursorWord -path=`expand('%:p:h')` -no-empty -buffer-name=gtags_d gtags_def<cr>
nnoremap <leader>r :DeniteCursorWord -path=`expand('%:p:h')` -no-empty -buffer-name=gtags_r gtags_ref<cr>
nnoremap <leader>g :DeniteCursorWord -path=`expand('%:p:h')` -no-empty -buffer-name=gtags_g gtags_grep<cr>
nnoremap <leader>t :Denite -path=`expand('%:p:h')` -no-empty -start-filter -buffer-name=gtags_t gtags_completion<cr>
nnoremap <leader>f :Denite -path=`expand('%:p:h')` -no-empty -start-filter -buffer-name=gtags_f gtags_file<cr>
nnoremap <leader>F :Denite -path=`expand('%:p:h')` -no-empty -start-filter -buffer-name=gtags_f gtags_files<cr>
nnoremap <leader>p :Denite -path=`expand('%:p:h')` -no-empty -start-filter -buffer-name=gtags_p gtags_path<cr>

autocmd FileType denite call s:denite_my_settings()
function! s:denite_my_settings() abort
	nnoremap <silent><buffer><expr> <CR> denite#do_map('do_action')
	nnoremap <silent><buffer><expr> d denite#do_map('do_action', 'delete')
	nnoremap <silent><buffer><expr> p denite#do_map('do_action', 'preview')
	nnoremap <silent><buffer><expr> q denite#do_map('quit')
	nnoremap <silent><buffer><expr> i denite#do_map('open_filter_buffer')

	nnoremap <silent><buffer><expr> <C-t> denite#do_map('do_action', 'tabopen')
	nnoremap <silent><buffer><expr> <C-s> denite#do_map('do_action', 'split')
	nnoremap <silent><buffer><expr> <C-v> denite#do_map('do_action', 'vsplit')
	nnoremap <silent><buffer><expr> <C-w><C-t> denite#do_map('do_action', 'tabswitch')
	nnoremap <silent><buffer><expr> <C-w><C-s> denite#do_map('do_action', 'splitswitch')
	nnoremap <silent><buffer><expr> <C-w><C-v> denite#do_map('do_action', 'vsplitswitch')
endfunction

call denite#custom#alias('source', 'file/rec/git', 'file/rec')
call denite#custom#var('file/rec/git', 'command', ['git', 'ls-files', '-co', '--exclude-standard'])
call denite#custom#source('file/rec', 'sorters', ['sorter/sublime'])
call denite#custom#option('_', 'winheight', 10)

" NeoMRU
let g:neomru#do_validate=0

" Airline
if !exists('g:airline_symbols')
	let g:airline_symbols={}
endif
let g:airline_left_sep=''
let g:airline_left_alt_sep=''
let g:airline_right_sep=''
let g:airline_right_alt_sep=''
let g:airline_symbols.branch=''
let g:airline_symbols.readonly=''
let g:airline_symbols.linenr='☰'
let g:airline_symbols.maxlinenr=''
let g:airline_theme='powerlineish'
let g:airline#extensions#whitespace#enabled=1

" nvim-tree.lua
let g:nvim_tree_width=40
let g:nvim_tree_ignore=['.git', 'node_modules', '.cache']
let g:nvim_tree_gitignore=0
let g:nvim_tree_indent_markers=1
let g:nvim_tree_hide_dotfiles=1
let g:nvim_tree_git_hl=1
let g:nvim_tree_highlight_opened_files=1
let g:nvim_tree_tab_open=1
let g:nvim_tree_width_allow_resize =1
let g:nvim_tree_disable_netrw=1
let g:nvim_tree_hijack_netrw=1
let g:nvim_tree_add_trailing=1
let g:nvim_tree_group_empty=1
let g:nvim_tree_hijack_cursor=1
let g:nvim_tree_update_cwd=0
let g:nvim_tree_icons={ 'default': '' }

nnoremap <C-n> :NvimTreeToggle<CR>
nnoremap <leader>m :NvimTreeRefresh<CR>
nnoremap <leader>n :NvimTreeFindFile<CR>

" nvim-colorizer
lua require 'colorizer'.setup()

" Ranger
let g:ranger_map_keys=0
nnoremap <leader>e :Ranger<CR>

" hop.nvim
noremap <leader>ww :HopWord<CR>
noremap <leader>l :HopLine<CR>
noremap <leader>s :HopPattern<CR>
noremap <leader>wc :HopChar1<CR>

" ALE
nnoremap <F5> :ALEDetail<CR>
nnoremap <F6> :ALEHover<CR>
nnoremap <F7> :ALEFix<CR>
let g:airline#extensions#ale#enabled=1
let g:ale_cache_executable_check_failures=1
let g:ale_virtualtext_cursor=1
let g:ale_echo_cursor=1
let g:ale_echo_delay=200
let g:ale_virtualtext_delay=200
let g:ale_sign_error='✘'
let g:ale_sign_warning='⚠'
let g:ale_linters={
			\	'python': ['mypy', 'yapf', 'autopep8', 'pycodestyle'],
			\	'c++': ['g++'],
			\}

let g:ale_fixers={
			\	'c': ['clang-format', 'trim_whitespace'],
			\	'cpp': ['clang-format', 'trim_whitespace'],
			\	'python': ['autopep8', 'yapf', 'trim_whitespace'],
			\	'typescript': ['eslint', 'trim_whitespace'],
			\	'typescript.tsx': ['eslint', 'trim_whitespace'],
			\	'javascript': ['eslint', 'trim_whitespace'],
			\	'html': ['prettier', 'trim_whitespace'],
			\	'css': ['prettier', 'trim_whitespace'],
			\	'scss': ['prettier', 'trim_whitespace'],
			\	'less': ['prettier', 'trim_whitespace'],
			\	'json': ['prettier', 'trim_whitespace'],
			\	'markdown': ['prettier', 'trim_whitespace'],
			\}

" Language Syntax
let g:python_highlight_all=1
let g:jsx_ext_required=0

" Deoplete
let g:deoplete#enable_at_startup=1
call deoplete#custom#option('_', 'min_pattern_length', 0)
autocmd InsertLeave,CompleteDone * pclose!

" Deoplete-clang
let g:deoplete#sources#clang#libclang_path='/usr/lib/libclang.so'
let g:deoplete#sources#clang#clang_header='/usr/lib/clang'

" Deoplete-jedi
let g:deoplete#sources#jedi#show_docstring=1

" Echodoc
let g:echodoc#enable_at_startup=1
let g:echodoc#type='floating'

" Neosnippets
imap <expr><tab> neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<tab>"
smap <expr><tab> neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<tab>"
let g:neosnippet#enable_snipmate_compatibility=1

" Markdown
let g:vim_markdown_folding_disabled=1
let g:vim_markdown_conceal=0

" Markdown Preview
nmap <C-m> <Plug>MarkdownPreviewToggle

" indent-blankline
lua require('indent_blankline').setup({char_list = {'|', '¦', '┆'}, buftype_exclude = {'terminal'}})
