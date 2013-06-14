" git clone http://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
" git clone http://github.com/gmarik/vundle.git "%USERPROFILE%/.vim/bundle/vundle"
source $VIMRUNTIME/vimrc_example.vim
" source $VIMRUNTIME/mswin.vim
" behave mswin

set rtp+=~/.vim/bundle/vundle/
" set rtp+=~/.vim/bundle/powerline/powerline/bindings/vim
call vundle#rc()
" let Vundle manage Vundle
" required! 
Bundle 'gmarik/vundle'
Bundle 'polyrabbit/molokai'
Bundle 'Gundo'
Bundle 'neocomplcache'
"Bundle 'liancheng/snipmate-snippets'
" Bundle 'taglist.vim'
Bundle 'majutsushi/tagbar'
" Bundle 'fholgado/minibufexpl.vim'
Bundle 'The-NERD-tree'
Bundle 'kien/ctrlp.vim'
Bundle 'tComment'
Bundle 'FuDesign2008/AutoClose.vim'
Bundle 'pyflakes.vim'
Bundle 'tpope/vim-surround'
Bundle 'Lokaltog/vim-powerline'
Bundle 'skammer/vim-css-color'
" Bundle 'jeffkreeftmeijer/vim-numbertoggle'
Bundle 'tpope/vim-fugitive'
Bundle 'scrooloose/syntastic'
" Bundle 'troydm/easytree.vim'
" Bundle 'Valloric/YouCompleteMe'
filetype plugin indent on
syntax on

set nocompatible
if has("gui_win32")
    set path+=C:/Python27/Lib/**
else
    set path+=/usr/lib/python2.7/**
end

" set nu
set rnu

set tabstop=4
set shiftwidth=4
set expandtab
set autoindent
" 方便在开启了et后使用退格（backspace）键，每次退格将删除X个空格
set softtabstop=4

" autoload
set autoread

set cursorline
"set clipboard+=unnamed
set nobackup
set noswapfile
set nowritebackup

" Set <leader>
" search reversely, opposite to ;
" let mapleader = ","

set mousemodel=popup
" 在状态栏显示正在输入的命令
set showcmd
set noerrorbells

cmap w!! w !sudo tee > /dev/null %
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

if has("gui_win32")
    autocmd FileType python noremap <F5> :w<cr>:!start cmd /c % & pause<CR>
    autocmd FileType python inoremap <F5> <Esc>:w<cr>:!start cmd /c % & pause<CR>
else
    autocmd FileType python noremap <F5> :w<cr>:pyfile %<CR>
    autocmd FileType python inoremap <F5> <Esc>:w<cr>:pyfile %<CR>
end

set autochdir
set foldenable
" set foldcolumn=3
" autocmd FileType python setlocal foldmethod=indent
set foldlevelstart=99

set completeopt=preview,menu

let g:molokai_original = 1
if has("gui_running")
    colorscheme molokai
else
    colorscheme desert
endif
highlight SpellBad term=underline gui=undercurl guisp=Orange 

set laststatus=2
let g:Powerline_symbols = 'compatible'

set completeopt-=preview
" NeoComplCache
let g:neocomplcache_enable_at_startup=1
"let g:neoComplcache_disableautocomplete=1
let g:neocomplcache_enable_underbar_completion = 1
let g:neocomplcache_enable_camel_case_completion = 1
let g:neocomplcache_enable_smart_case = 1
let g:neocomplcache_min_syntax_length = 1
let g:neocomplcache_min_keyword_length = 1
let g:neocomplcache_enable_underbar_completion = 1
let g:neocomplcache_enable_display_parameter = 1
let g:neocomplcache_enable_wildcard = 1
let g:neocomplcache_enable_auto_close_preview = 1
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

set tags=tags;/
" taglist
if has("gui_win32")
    let g:tagbar_ctags_bin="~/ctags.exe"
end
" let Tlist_Show_One_File = 1
" let Tlist_Exit_OnlyWindow = 1
" let Tlist_Use_Right_Window = 1
" let Tlist_File_Fold_Auto_Close=1
" let Tlist_Process_File_Always=0
" let Tlist_Inc_Winwidth=0
" let Tlist_GainFocus_On_ToggleOpen = 1
" let Tlist_Display_Prototype = 1
" let Tlist_Auto_Open=1 

" map p to be the key of preview like tagbar
let g:NERDTreeMapJumpParent = 'gp'
let g:NERDTreeMapPreview = 'p'
" for Java
let g:NERDTreeCasadeOpenSingleChildDir=1
let g:NERDTreeChDirMode=2

let g:pyflakes_use_quickfix = 0

let g:syntastic_check_on_open = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_enable_highlighting = 0

" Tagbar uses CursorHold event to toggle autoupdate the current tag, 
" whose period is updatetime(default 4000)
set updatetime=1000
" sorted according to their order in the source file, not by name.
let g:tagbar_sort = 0
let g:tagbar_autofocus = 1

nmap <F3> :TagbarToggle<cr>
nmap <f4> :GundoToggle<cr>
nmap <F2> :NERDTreeToggle<cr>

nmap gb :CtrlPBuffer<cr>
" let g:ctrlp_by_filename = 1
let g:ctrlp_follow_symlinks=1

noremap 00 :CtrlPMRU<CR>
let g:ctrlp_open_multiple_files = 'v'
let g:ctrlp_mruf_max = 250

set wildignore+=*/tmp/*,*.so,*.swp,*.zip
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git)$',
  \ 'file': '\v\.(log|jpg|png|jpeg)$',
  \ }

set fileencodings=ucs-bom,utf-8,cp936,gb18030,big5,euc-jp,euc-kr,latin1
set encoding=utf-8
" it conflicts with powerline currently
" autocmd bufwritepost .vimrc source $MYVIMRC 

if has("gui_gtk2")
	set guifont=Courier\ 10\ Pitch\ 11 
elseif has("gui_macvim")
	set guifont=Consolas:h11:cANSI
elseif has("gui_win32")                              
    set guifont=Consolas:h11:cANSI
end
