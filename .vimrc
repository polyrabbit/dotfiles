" git clone http://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
" git clone http://github.com/gmarik/vundle.git "%USERPROFILE%/.vim/bundle/vundle"

set nocompatible              " be iMproved, required
filetype off                  " required

" source $VIMRUNTIME/vimrc_example.vim
" source $VIMRUNTIME/mswin.vim
" behave mswin

" Set <leader>, should be ASAP
let mapleader = ","

set rtp+=~/.vim/bundle/vundle/
call vundle#begin()
" let Vundle manage Vundle
" required! 
Plugin 'gmarik/vundle'

Plugin 'polyrabbit/molokai'
Plugin 'Gundo'
"Plugin 'liancheng/snipmate-snippets'
Plugin 'tComment'
Plugin 'Raimondi/delimitMate'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-repeat'
" Plugin 'Lokaltog/vim-powerline'
Plugin 'skammer/vim-css-color'
" Plugin 'jeffkreeftmeijer/vim-numbertoggle'
Plugin 'tpope/vim-fugitive'
" Plugin 'rosenfeld/conque-term'
Plugin 'TeTrIs.vim'

Plugin 'davidhalter/jedi-vim'
let g:jedi#auto_vim_configuration = 0
let g:jedi#use_tabs_not_buffers = 0
" see https://github.com/davidhalter/jedi-vim/issues/258
let g:jedi#popup_on_dot = 0
let g:jedi#popup_select_first = 0
set completeopt-=preview

Plugin 'neocomplcache'
" NeoComplCache
let g:neocomplcache_enable_at_startup=1
" let g:neoComplcache_disableautocomplete=1
let g:neocomplcache_enable_camel_case_completion = 1
let g:neocomplcache_enable_smart_case = 1
let g:neocomplcache_min_syntax_length = 1
let g:neocomplcache_min_keyword_length = 1
let g:neocomplcache_enable_underbar_completion = 1
let g:neocomplcache_enable_display_parameter = 1
let g:neocomplcache_enable_wildcard = 1
let g:neocomplcache_enable_auto_close_preview = 1
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" Enable omni completion, from vim builtin
" autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
" autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
" autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
" autocmd FileType python setlocal omnifunc=jedi#completions
" autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" make neocomplcache use jedi#completions omini function for python scripts
if !exists('g:neocomplcache_omni_functions')
    let g:neocomplcache_omni_functions = {}
    let g:neocomplcache_omni_functions['python'] = 'jedi#completions'
endif
" make Vim call omni function when below patterns matchs
if !exists('g:neocomplcache_keyword_patterns')
    let g:neocomplcache_keyword_patterns = {}
endif
let g:neocomplcache_keyword_patterns['default'] = '\h\w*'
if !exists('g:neocomplcache_force_omni_patterns')
    let g:neocomplcache_force_omni_patterns = {}
endif
let g:neocomplcache_force_omni_patterns.python = '[^. \t]\.\w*'
" Set for golang
if !exists('g:neocomplcache_omni_patterns')
    let g:neocomplcache_omni_patterns = {}
endif
let g:neocomplcache_omni_patterns.go = '\h\w*\.\?'

Plugin 'bling/vim-airline'
" let g:airline#extensions#tabline#enabled = 1
let g:airline_section_c = '%F'
let g:airline_left_sep=''
let g:airline_right_sep=''
" let g:airline_branch_prefix = ' ⎇'
let g:airline_detect_paste=1
let g:airline_detect_modified=0
let g:airline_detect_iminsert=0

Plugin 'Lokaltog/vim-easymotion'
" Bind togather, much easier to modify
let g:EasyMotion_leader_key = ','
let g:EasyMotion_smartcase = 1

" Plugin 'troydm/easytree.vim'
" Plugin 'Valloric/YouCompleteMe'

" Plugin 'SirVer/ultisnips' " worth a try

Plugin 'kien/rainbow_parentheses.vim'
let g:rbpt_colorpairs = [
            \ ['brown',       'RoyalBlue3'],
            \ ['Darkblue',    'SeaGreen3'],
            \ ['darkgray',    'DarkOrchid3'],
            \ ['darkgreen',   'firebrick3'],
            \ ['darkcyan',    'RoyalBlue3'],
            \ ['darkred',     'SeaGreen3'],
            \ ['darkmagenta', 'DarkOrchid3'],
            \ ['brown',       'firebrick3'],
            \ ['gray',        'RoyalBlue3'],
            \ ['black',       'SeaGreen3'],
            \ ['darkmagenta', 'DarkOrchid3'],
            \ ['Darkblue',    'firebrick3'],
            \ ['darkgreen',   'RoyalBlue3'],
            \ ['darkcyan',    'SeaGreen3'],
            \ ['darkred',     'DarkOrchid3'],
            \ ['red',         'firebrick3'],
            \ ]
let g:rbpt_max = 16
let g:rbpt_loadcmd_toggle = 0
au VimEnter * RainbowParenthesesToggle
au Syntax   * RainbowParenthesesLoadRound
au Syntax   * RainbowParenthesesLoadSquare
au Syntax   * RainbowParenthesesLoadBraces

Plugin 'mileszs/ack.vim'

" let Tlist_Show_One_File = 1
" let Tlist_Exit_OnlyWindow = 1
" let Tlist_Use_Right_Window = 1
" let Tlist_File_Fold_Auto_Close=1
" let Tlist_Process_File_Always=0
" let Tlist_Inc_Winwidth=0
" let Tlist_GainFocus_On_ToggleOpen = 1
" let Tlist_Display_Prototype = 1
" let Tlist_Auto_Open=1

Plugin 'The-NERD-tree'
" map p to be the key of preview like tagbar
let g:NERDTreeMapJumpParent = 'gp'
let g:NERDTreeMapPreview = 'p'
" for Java
let g:NERDTreeCasadeOpenSingleChildDir=1
let g:NERDTreeChDirMode=2

Plugin 'syntastic'
" set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
" set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
" let g:syntastic_auto_loc_list = 1
" let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" see http://vim.wikia.com/wiki/Automatically_fitting_a_quickfix_window_height
au FileType qf call AdjustWindowHeight(3, 10)
function! AdjustWindowHeight(minheight, maxheight)
  exe max([min([line("$"), a:maxheight]), a:minheight]) . "wincmd _"
endfunction

" Plugin 'pyflakes.vim'
" let g:pyflakes_use_quickfix = 1

Plugin 'argtextobj.vim'
Plugin 'unimpaired.vim'
" Plugin 'valloric/MatchTagAlways'
Plugin 'gregsexton/MatchTag'

Plugin 'majutsushi/tagbar'
" see http://stackoverflow.com/a/5019111
set tags=./tags,./TAGS,tags;/,TAGS;/  " tagbar creates the tags it needs on-the-fly in-memory without creating any files, so no need to set this now.
if has("gui_win32")
    let g:tagbar_ctags_bin="~/ctags.exe"
end
" Tagbar uses CursorHold event to toggle autoupdate the current tag, 
" whose period is updatetime(default 4000)
set updatetime=1000
" sorted according to their order in the source file, not by name.
let g:tagbar_sort = 0
let g:tagbar_autofocus = 1
nmap <F3> :TagbarToggle<cr>

nmap <f4> :GundoToggle<cr>
nmap <F2> :NERDTreeToggle<cr>

Plugin 'kien/ctrlp.vim'
nmap gb :CtrlPBuffer<cr>
" let g:ctrlp_by_filename = 1
let g:ctrlp_follow_symlinks=1

noremap 00 :CtrlPMRU<CR>
let g:ctrlp_open_multiple_files = 'v'
let g:ctrlp_mruf_max = 250

Plugin 'fatih/vim-go'
au FileType go nmap gd <Plug>(go-def)
au FileType go nmap <Leader>s <Plug>(go-def-split)
au FileType go nmap <Leader>v <Plug>(go-def-vertical)
au FileType go nmap <Leader>t <Plug>(go-def-tab)

au FileType go nmap <Leader>i <Plug>(go-info)

au FileType go nmap  <leader>r  :w<cr><Plug>(go-run)
" au FileType go nmap  <leader>b  <Plug>(go-build)

au FileType go nmap <Leader>d <Plug>(go-doc)
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1

Plugin 'kshenoy/vim-signature'

" Plugin 'fholgado/minibufexpl.vim'
" Move one buffer forward in the most recent used buffer list.
" map <C-Tab> :MBEbf<cr>
" map <C-Tab> :MBEbf<cr>
" Move one buffer backward in the most recent used buffer list.
" map <C-S-Tab> :MBEbb<cr>

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
source $VIMRUNTIME/vimrc_example.vim

syntax on
set rnu
set nowrap
set hlsearch
set incsearch

set tabstop=4
set shiftwidth=4
set expandtab
set autoindent
" 方便在开启了et后使用退格（backspace）键，每次退格将删除X个空格
set softtabstop=4
set t_Co=256

" autoload
set autoread

set cursorline
"set clipboard+=unnamed
set nobackup
set noswapfile
set nowritebackup

set hidden  "don't unload buffer when it is abandoned
if !isdirectory("/tmp/.vimundodir")
    call mkdir("/tmp/.vimundodir", "p")
endif
set undodir=/tmp/.vimundodir
set undofile
set undolevels=1000 "maximum number of changes that can be undone
set undoreload=10000 "maximum number lines to save for undo on a buffer reload

set mouse=r
set mousemodel=popup
" 在状态栏显示正在输入的命令
set showcmd
set noerrorbells

" diff mode
set diffopt+=iwhite

" easy for copy-paste
nmap ! "+
vmap ! "+

" easier navigation between split windows
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l
nnoremap <C-up> <C-w>-
nnoremap <C-down> <C-w>+
nnoremap <C-left> <C-w>>
nnoremap <C-right> <C-w><

set autochdir
set foldenable
" set foldcolumn=3
" autocmd FileType python setlocal foldmethod=indent
set foldlevelstart=99

let g:molokai_original = 1
if has("gui_running")
    colorscheme molokai
else
    colorscheme desert
endif
" highlight SpellBad term=underline gui=undercurl guisp=Orange 

set laststatus=2
set wildignore+=*.so,*.swp,*.zip
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git)$',
  \ 'file': '\v\.(log|jpg|png|jpeg)$',
  \ }

cmap w!! w !sudo tee % >/dev/null

" fileencoding为文件的编码, fileencodings为尝试的编码, encoding为vim内部编码
" http://edyfox.codecarver.org/html/vim_fileencodings_detection.html
set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1
" set encoding=utf-8

if has("gui_gtk2")
	set guifont=Courier\ 10\ Pitch\ 11 
elseif has("gui_macvim")
	set guifont=Consolas:h11:cANSI
elseif has("gui_win32")                              
    set guifont=Consolas:h11:cANSI
end
