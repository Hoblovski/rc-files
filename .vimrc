set nocompatible
syntax on
source $VIMRUNTIME/vimrc_example.vim
behave xterm

imap <Esc>oA <Esc>ki

set nobackup
set nowritebackup
set noswapfile

set diffexpr=MyDiff()

function MyDiff()
    let opt = '-a --binary '
    if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
    if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
    let arg1 = v:fname_in
    if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
    let arg2 = v:fname_new
    if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
    let arg3 = v:fname_out
    if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
    let eq = ''
    if $VIMRUNTIME =~ ' '
        if &sh =~ '\<cmd'
            let cmd = '""' . $VIMRUNTIME . '\diff"'
            let eq = '"'
        else
            let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
        endif
    else
        let cmd = $VIMRUNTIME . '\diff'
endif
silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
endfunction

func Eatchar(pat)
  let c = nr2char(getchar(0))
  return (c =~ a:pat) ? '' : c
endfunc


let CountKEYAUTOCOMPLETION = 2
function ReDefineKEYAUTOCOMPLETION()
    imap {} {}
    imap () ()
if (g:CountKEYAUTOCOMPLETION == 0)
    iab <silent> if `IABIF<Left><C-R>=Eatchar('\s')<CR>
    iab <silent> while `IABWHILE<Left><C-R>=Eatchar('\s')<CR>
    iab <silent> for `IABFOR<Left><C-R>=Eatchar('\s')<CR>
    inoremap `IABIF if<Space>()
    inoremap `IABWHILE while<Space>()
    inoremap `IABFOR for<Space>()
    inoremap {<CR> {<CR>}<Up><End><CR>
    imap () ()<Left>
    echo "Deep Auto Completion"
    let g:CountKEYAUTOCOMPLETION = 1
else
    if (g:CountKEYAUTOCOMPLETION == 1)
        iunab if
        iunab while
        iunab for
        iunmap `IABIF
        iunmap `IABWHILE
        iunmap `IABFOR
        echo "Shallow Auto Completion"
        let g:CountKEYAUTOCOMPLETION = 2
    else
        iunmap {}
        iunmap ()
        let g:CountKEYAUTOCOMPLETION = 0
        echo "No Completion"
    endif
endif
endfunction
colorscheme default
set autoindent
set nocindent
set nosmartindent
set tabstop=4
set shiftwidth=4
set number
set expandtab
set backspace=indent,eol,start
set guioptions-=T
set guioptions-=r
set guioptions-=b
set guioptions-=m
set guioptions-=i
set sts=4
set scrolloff=3
set nowrap
set mouse=
set makeprg=g++\ %
set cul

iab BI BigInteger
iab BD BigDecimal
iab pubsta public static
iab prista private static
iab SYSO System.out
iab SYSP System.out.println
iab SYSI System.in
iab scse std::cout<< <<std::endl
iab IO I/O

command Strip %s/\s\+$// | nohlsearch
command W w
command Q q
command Chkif /if.*[^!=<>]=[^=].*
command EditVIMRC e $VIMRUNTIME/../_vimrc
command CMD !start cmd
command PY !start python
command -nargs=1 -complete=file TF tabe <args>.cpp | vs <args>.h
map <F2> :w<CR>
map <F3> :nohlsearch<CR>
map <F4> :e %:p:s,.h$,.X123X,:s,.cpp$,.h,:s,.X123X$,.cpp,<CR> 
map <F5> :e<CR>
map <M-Left> <C-Up>
map <M-Right> <C-Down>
map <Up> gT
map <Down> gt
map <Left> <C-W>h
map <Right> <C-W>l
map ` gt
imap {<CR> {<CR>}<C-O>O
noremap <C-H> :substitute///g<Left><Left><Left>
noremap <C-J> :%substitute///g<Left><Left><Left>
noremap <C-X> "_x
noremap <C-D> "_d
noremap Y y$
imap <M-Right> <Esc>5<Right>i
imap <M-Left> <Esc>5<Left>i
imap <F2> <C-O>:w<CR>
inoremap <Esc> <Esc><C-L>
inoremap <C-E> <C-X><C-E>
inoremap <C-Y> <C-X><C-Y>
inoremap <C-Q> <Space><C-U><BS><CR>
inoremap <C-CR> <Right>
inoremap <C-F> <C-O>F
inoremap <C-G> <C-O>f
map <C-Tab> <C-PageDown>
unmap Q
cmap *? \{-}
map <middlemouse> <nop>

function Compile()
    let cft = &ft
    if cft =~ "cpp"
        exec "!g++ --std=c++11 \"%\" -g -o \"%<\.exe\""
        call feedkeys("\<CR>\<C-L>", "nt");
    elseif cft =~ "c"
        exec "!mingw32-gcc -std=c99 \"%\" -g -o \"%<\.exe\""
        call feedkeys("\<CR>\<C-L>", "nt");
    elseif cft =~ "java"
        exec "!javac \"%\" -Xdiags:verbose"
        call feedkeys("\<CR>")
    elseif cft =~ "py"
        exec "!python \"%\""
        call feedkeys("\<CR>\<C-L>", "nt");
    endif
endfunction

function Run()
    if (&ft =~ "cpp")
        exec "!\"%<.exe\""
        call feedkeys("\<CR>\<C-L>", "nt")
    elseif (&ft =~ "c")
        exec "!\"%<.exe\""
        call feedkeys("\<CR>\<C-L>", "nt")
    elseif (&ft =~ "java")
        exec "!java \"%<\""
        call feedkeys("\<CR>\<C-L>", "nt")
    endif
endfunction

map <F8> :exec "!start gdb %<.exe"<CR><C-L>
map <F9> :call Run()<CR>
map <C-F9> :call Compile()<CR>

"   Auto Completion

autocmd VimEnter * map <F1> :call ReDefineKEYAUTOCOMPLETION()<CR>| :call ReDefineKEYAUTOCOMPLETION()

function CursorBeforeClosingParenthesis()
    return (getline(".")[col(".")-1]==")")
endfunction

set cot=menu,menuone
inoremap <Tab> <C-R>=getline('.')[col('.')-2]=~?'\k'?
    \"\<lt>C-n>":
    \"\<lt>Tab>"
    \<CR>

ino <CR> <C-R>=CursorBeforeClosingParenthesis()?"\<lt>Right>":"\<lt>CR>"<CR>

set fileformat=unix

""" BEGIN AUTO COMPLETION
"augroup MyAutoComplete
"    au!
"    au InsertCharPre * if
"    \ !exists('s:complete') &&
"    \ !pumvisible() &&
"    \ getline('.')[col('.')-2].v:char =~# '\k\k' |
"        \ let s:complete = 1 |
"        \ noautocmd call feedkeys("\<C-n>\<C-p>", "nt") |
"    \ endif
"    au CompleteDone * if exists('s:complete') | unlet s:complete | endif
"augroup END

"set pumheight=10

"augroup MyAutoComplete
"    au!
"    au InsertCharPre * if
"    \ !exists('s:complete') &&
"    \ !pumvisible() &&
"    \ getline('.')[col('.')-2].v:char =~# '\k\k' |
"        \ let s:complete = 1 |
"        \ noautocmd call feedkeys("\<C-n>\<C-p>", "nt") |
"    \ endif
"    au CompleteDone * if exists('s:complete') | unlet s:complete | endif
"augroup END
""" END AUTO COMPLETION

"   Mathematical functions

function IsPrime(n)
    let l:q = ceil(sqrt(a:n))
    let l:i = 2
    while l:i < l:q
        if a:n % l:i == 0
            return 0
        endif
        let l:i += 1
    endwhile
    return 1
endfunction

function Divise(n)
    let l:v = a:n
    let l:q = ceil(sqrt(l:v))
    let l:i = 2
    echo "======== Divising" a:n "BEGIN"
    while l:i < l:q
        if l:v % l:i == 0
            let l:c = 0
            while l:v % l:i == 0
                let l:c += 1
                let l:v = l:v / l:i
            endwhile
            echo "    " l:i "  :  " l:c
        endif
        let l:i += 1
    endwhile
    if l:v != 1
        echo "    " l:v "  :   1"
    endif
    echo "======== Divising" a:n "END"
endfunction

""" BEGIN SHOW TAB LINE
"set showtabline=2 " always show tabs in gvim, but not vim
" set up tab labels with tab number, buffer name, number of windows
function! GuiTabLabel()
  let label = ''
  let bufnrlist = tabpagebuflist(v:lnum)
  " Add '+' if one of the buffers in the tab page is modified
  for bufnr in bufnrlist
    if getbufvar(bufnr, "&modified")
      let label = '+'
      break
    endif
  endfor
  " Append the tab number
  let label .= v:lnum.' '
  " Append the buffer name
  let name = bufname(bufnrlist[tabpagewinnr(v:lnum) - 1])
  if name == ''
    " give a name to no-name documents
    if &buftype=='quickfix'
      let name = '[Quickfix List]'
    else
      let name = '[No Name]'
    endif
  else
    " get only the file name
    let name = fnamemodify(name,":t")
  endif
  let label .= name
  " Append the number of windows in the tab page
  let wincount = tabpagewinnr(v:lnum, '$')
  return label . ' ' . wincount
endfunction
set guitablabel=%{GuiTabLabel()}
""" END SHOW TAB LINE

""" INITIALISE NORMAL
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

function s:CompleteTags()
  inoremap <buffer> ><Tab> ></<C-x><C-o><Esc>:startinsert!<CR><C-O>?</<CR>
" inoremap <buffer> ><Leader> >
  inoremap <buffer> ><CR> ></<C-x><C-o><Esc>:startinsert!<CR><C-O>?</<CR><CR><Tab><CR><Up><C-O>$
endfunction
autocmd BufRead,BufNewFile *.html,*.js,*.xml call s:CompleteTags()


""" DISABLE MOUSE SCROLLING
map <ScrollWheelUp> <nop>
map <S-ScrollWheelUp> <nop>
map <C-ScrollWheelUp> <nop>
map <ScrollWheelDown> <nop>
map <S-ScrollWheelDown> <nop>
map <C-ScrollWheelDown> <nop>
map <ScrollWheelLeft> <nop>
map <S-ScrollWheelLeft> <nop>
map <C-ScrollWheelLeft> <nop>
map <ScrollWheelRight> <nop>
map <S-ScrollWheelRight> <nop>
map <C-ScrollWheelRight> <nop>


""" VUNDLE
"""" set rtp+=~/.vim/bundle/vundle
"""" call vundle#rc()   
"""" Bundle 'gmarik/Vundle'

""" Bundle 'davidhalter/jedi-vim'
""" set omnifunc=jedi#completions

""" Bundle 'Valloric/YouCompleteMe'

