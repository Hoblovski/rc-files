set nocompatible
source $VIMRUNTIME/vimrc_example.vim
behave xterm
syntax on

" ****************************************************************************
""" set's
set nobackup
set nowritebackup
set noswapfile

set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set backspace=indent,eol,start
set autoindent

set number
set cursorline
set scrolloff=3

set fileencoding=utf8
set fileformat=unix

set mouse=


""" command's
command Strip %s/\s\+$// | nohlsearch
command W w
command Q q


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
function s:CompleteTags()
  inoremap <buffer> ><Tab> ></<C-x><C-o><Esc>:startinsert!<CR><C-O>?</<CR>
" inoremap <buffer> ><Leader> >
  inoremap <buffer> ><CR> ></<C-x><C-o><Esc>:startinsert!<CR><C-O>?</<CR><CR><Tab><CR><Up><C-O>$
endfunction
autocmd BufRead,BufNewFile *.html,*.js,*.xml call s:CompleteTags()


" ****************************************************************************
