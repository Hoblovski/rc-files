set nocompatible
behave xterm
syntax on
colorscheme solarized
set background=dark


""" set's ****************************************

set noexpandtab
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

set fileencoding=utf8
set encoding=utf8
set fileformat=unix
set mouse=


""" command's ****************************************
command Strip %s/\s\+$// | nohlsearch
command W w
command Q q
command T tabe


""" map's ****************************************
map <F2> :w<CR>
imap <F2> <C-O>:w<CR>
map <F3> :nohlsearch<CR>
map <F5> :e<CR>
map <Up> gT
map <Down> gt
map <Left> <C-W>h
map <Right> <C-W>l
noremap <C-H> :s///g<Left><Left><Left>
noremap <C-J> :%s///g<Left><Left><Left>
noremap Y y$
imap {<CR> {<CR>}<C-O>O
inoremap <Esc> <Esc><C-L>
inoremap <C-E> <C-X><C-E>
inoremap <C-Y> <C-X><C-Y>
" use Ctrl+C and Ctrl+V to work with system clipboards
nmap <C-c> "+Y
nmap <C-v> "+p
nnoremap <C-Q> <C-V>


""" Simple Tab Auto Completion
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


" fucking tex bold matrices/vectors
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


""" Vundle
filetype off
set runtimepath+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'junegunn/vim-easy-align'
Plugin 'vim-scripts/DrawIt'
call vundle#end()            " required
filetype plugin indent on    " required

" easy align
nmap <C-s> <Plug>(EasyAlign)
xmap <C-s> <Plug>(EasyAlign)

