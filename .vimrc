set nocompatible
source $VIMRUNTIME/vimrc_example.vim
behave xterm
syntax on

syntax enable
set background=dark
colorscheme solarized

iab HH \mathbf{H}
iab QQ \mathbf{Q}
iab RR \mathbf{R}
iab AA \mathbf{A}
iab BB \mathbf{B}
iab CC \mathbf{C}
iab UU \mathbf{U}
iab II \mathbf{I}
iab cc \mathbf{c}
iab MM \mathbf{M}
iab NN \mathbf{N}
iab ff \mathbf{f}
iab PP \mathbf{P}
iab LL \mathbf{L}
iab ee \mathbf{e}
iab DD \mathbf{D}
iab 11 \mathbf{1}
iab 00 \mathbf{0}
iab xx \mathbf{x}
iab yy \mathbf{y}
iab zz \mathbf{z}
iab ww \mathbf{w}
iab uu \mathbf{u}
iab vv \mathbf{v}
iab aa \mathbf{a}
iab bb \mathbf{b}


" ****************************************************************************
""" set's

set tabstop=8
set softtabstop=8
set shiftwidth=8

set nobackup
set nowritebackup
set noswapfile
set noundofile

set backspace=indent,eol,start
set autoindent

set number
set cursorline
set scrolloff=3

set laststatus=2

"set fileencoding=utf8
"set encoding=utf8
set fileformat=unix

set mouse=


""" command's
command Strip %s/\s\+$// | nohlsearch
command W w
command Q q
command T tabe


""" map's
map <F2> :w<CR>
map <F3> :nohlsearch<CR>
map <F4> :e %:p:s,.h$,.X123X,:s,.cpp$,.h,:s,.X123X$,.cpp,<CR>
map <F5> :e<CR>
map <Up> gT
map <Down> gt
map <Left> <C-W>h
map <Right> <C-W>l
map ` gt
noremap <C-H> :substitute///g<Left><Left><Left>
noremap <C-J> :%substitute///g<Left><Left><Left>
noremap Y y$

imap <F2> <C-O>:w<CR>
imap {<CR> {<CR>}<C-O>O
" imap <Esc>oA <Esc>ki
inoremap <Esc> <Esc><C-L>
inoremap <C-E> <C-X><C-E>
inoremap <C-Y> <C-X><C-Y>

cmap *? \{-}

" use Ctrl+C and Ctrl+V to work with system clipboards
vmap <C-c> "+y
nmap <C-c> "+Y
nmap <C-v> "+p
nnoremap <C-Q> <C-V>

" ****************************************************************************


""" Auto Completion
function CursorBeforeClosingParenthesis()
    return (getline(".")[col(".")-1]==")")
endfunction
set cot=menu,menuone
inoremap <Tab> <C-R>=getline('.')[col('.')-2]=~?'\k'?
    \"\<lt>C-n>":
    \"\<lt>Tab>"
    \<CR>
ino <CR> <C-R>=CursorBeforeClosingParenthesis()?"\<lt>Right>":"\<lt>CR>"<CR>


""" insert C header gates
function! s:insert_gates()
  let gatename = substitute(toupper(expand("%:t")), "\\.", "_", "g")
  execute "normal! i#ifndef " . gatename
  execute "normal! o#define " . gatename
  execute "normal! Go#endif // " . gatename
  normal! O
  normal! O
  normal! O
endfunction
function! s:insert_gates_src()
  let gatename = substitute(expand("%:t"), "\\.cpp", ".h", "g")
  execute "normal! i#include \"" . gatename . "\""
  normal! o
endfunction
autocmd BufNewFile *.{h,hpp} call <SID>insert_gates()
autocmd BufNewFile *.{cpp} call <SID>insert_gates_src()


""" complete HTML tags
" function s:CompleteTags()
"   inoremap <buffer> ><Tab> ></<C-x><C-o><Esc>:startinsert!<CR><C-O>?</<CR>
" " inoremap <buffer> ><Leader> >
"   inoremap <buffer> ><CR> ></<C-x><C-o><Esc>:startinsert!<CR><C-O>?</<CR><CR><Tab><CR><Up><C-O>$
" endfunction
" autocmd BufRead,BufNewFile *.html,*.js,*.xml call s:CompleteTags()



""" Incremental Search
function Init(val)
    let g:SBegin = a:val
endfunction

function Inc(...)
    if a:0 == 0
        let retval = g:SBegin
        let g:SBegin = g:SBegin + 1
        return retval
    else
        let retval = g:SBegin
        let g:SBegin = g:SBegin + a:1
        return retval
    endif
endfunction

" PyMatcher for CtrlP
" if !has('python3')
"     echo 'In order to use pymatcher plugin, you need +python compiled vim'
" else
"     let g:ctrlp_match_func = { 'match': 'pymatcher#PyMatch' }
" endif

" easy align
nmap <C-s> <Plug>(EasyAlign)
xmap <C-s> <Plug>(EasyAlign)


" ****************************************************************************
""" Vundle

filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
 
" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
" Plugin 'ctrlpvim/ctrlp.vim'
" Plugin 'FelikZ/ctrlp-py-matcher'
Plugin 'junegunn/vim-easy-align'
Plugin 'vim-scripts/DrawIt'
Plugin 'altercation/vim-colors-solarized'
" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
" Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
" Plugin 'L9'
" Git plugin not hosted on GitHub
" Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
" Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
" Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Install L9 and avoid a Naming conflict if you've already installed a
" different version somewhere else.
" Plugin 'ascenator/L9', {'name': 'newL9'}

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
