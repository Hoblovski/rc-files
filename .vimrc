""" vim-plug
call plug#begin('~/.vim/bundle')
Plug 'junegunn/vim-easy-align'
Plug 'vim-scripts/DrawIt'
Plug 'whonore/Coqtail' | Plug 'let-def/vimbufsync'
Plug 'preservim/tagbar'
"Plug 'vim-scripts/CmdlineComplete'
Plug 'easymotion/vim-easymotion'
set rtp+=~/.fzf " fzf
" highlights
Plug 'pest-parser/pest.vim'
Plug 'mlr-msft/vim-loves-dafny'
Plug 'derekwyatt/vim-scala'
Plug 'plasticboy/vim-markdown'
Plug 'jrozner/vim-antlr'
Plug 'rust-lang/rust.vim'
"#Plug '~/.vim/bundle/vim-why3'
Plug '~/.vim/bundle/grammarspec'
Plug 'leafgarland/typescript-vim'
Plug 'tpope/vim-obsession'
Plug 'hoblovski/perwindow-search.vim'
call plug#end()

filetype plugin indent on

set nocompatible
behave xterm
syntax on
syntax enable
colorscheme slate
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
set nohlsearch

set number
set cursorline
set scrolloff=3
set laststatus=2

set fileencoding=utf8
set encoding=utf8
set fileformat=unix
set mouse=

setlocal spell spelllang=en_us
set nospell

""" command's ****************************************
command Strip %s/\s\+$// | nohlsearch
command W w
command Q q
command E e
command T tabe


""" map's ****************************************
nnoremap <silent> <F2> :call ToggleFoldFashion()<CR>
nnoremap <C-H> :keeppatterns s///g<Left><Left><Left>
vnoremap <C-H> :s///g<Left><Left><Left>
nnoremap <C-J> :keeppatterns %s///g<Left><Left><Left>
nnoremap <C-K> yiw:keeppatterns %s/\<<C-R>"\>//g<Left><Left>
vnoremap <C-K> :%s/\<<C-R>*\>//g<Left><Left>
nnoremap Y y$
inoremap <silent> {<CR> {<CR>}<C-O>O
inoremap <silent> , ,<Space>
inoremap <C-E> <C-X><C-E>
inoremap <C-Y> <C-X><C-Y>
" use Ctrl+C and Ctrl+V to work with system clipboards
vnoremap <C-c> "+y
nnoremap <C-v> "+p
nnoremap <C-Q> <C-V>
nnoremap . @q
" <CapsLock> is remapped to <Esc> via other methods
nmap <silent> <Tab> /<C-C>:w<CR>

nnoremap <silent> ) :keepp /\n\n\n<CR>jjj
nnoremap <silent> ( :keepp ?\n\n\n<CR>

""" abbreviations ================================
"ca t tabe %
"ca tn tabe
"ca s sp
"ca v vs
"ca T tabe
"ca S sp
"ca V vs

""" highlights ================================
highlight MyBreak cterm=bold term=bold ctermfg=white ctermbg=2
match MyBreak /\(=\{20}=\+\|-\{20}-\+\)/

highlight StatusLine   gui=bold    guifg=red   guibg=blue  ctermfg=magenta   ctermbg=blue

""" Other ================================

""" Simple Tab Auto Completion
function CursorBeforeClosingParenthesis()
    return (getline(".")[col(".")-1]==")")
endfunction
set cot=menu,menuone
inoremap <Tab> <C-R>=getline('.')[col('.')-2]=~?'\k'?
    \"\<lt>C-n>":
    \"\<lt>Tab>"
    \<CR>

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

""" Incremental Search and Replace
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

""" Set indent
function! s:SetTabs(a)
  let &tabstop=str2nr(a:a)
  let &softtabstop=str2nr(a:a)
  let &shiftwidth=str2nr(a:a)
endfunction
command! -nargs=1 TT call s:SetTabs(<args>)

""" Tex abbreviates
function MyTexSetup()
    iab eitem \begin{itemize}<CR>\item <CR>\end{itemize}<CR><C-O>2k<End>
    iab eenum \begin{enumerate}<CR>\item <CR>\end{enumerate}<CR><C-O>2k<End>
    iab equote \begin{itemize}<CR>\item <CR>\end{itemize}<CR><C-O>2k<End>
    iab xpara \paragraph{}<C-o>h
    iab eframe \begin{frame}{ }<CR><CR>\end{frame}<C-o>2k<C-o>$<C-o>h
    iab eblock \begin{block}{ }<CR><CR>\end{block}<C-o>2k<C-o>$<C-o>h
    iab bf \textbf
    iab tt \texttt
    iab it \textit
endfunc
autocmd BufEnter *.tex call MyTexSetup()

""" easy align
nmap <C-s> <Plug>(EasyAlign)
xmap <C-s> <Plug>(EasyAlign)
let g:easy_align_ignore_groups = ['String']

""" markdown
let g:vim_markdown_folding_disabled = 1
let g:tex_conceal = ""
let g:vim_markdown_math = 1
let g:vim_markdown_auto_insert_bullets = 0
let g:vim_markdown_new_list_item_indent = 0
let g:vim_markdown_toc_autofit = 1

function s:TocToggle()
    if index(["markdown", "qf"], &filetype) == -1
        return
    endif
    if get(getloclist(0, {'winid':0}), 'winid', 0)
        " the location window is open
        lclose
    else
        let prevwinid = win_getid()
        " the location window is closed
        Toc
        call win_gotoid(prevwinid)
    endif
endfunction
command TocToggle call s:TocToggle()


""" fzf
nnoremap <silent> <C-p> :FZF<CR>

function! s:GotoOrOpen(command, ...)
  for file in a:000
    if a:command == 'e'
      exec 'e ' . file
    else
      exec "tab drop " . file
    endif
  endfor
endfunction
command! -nargs=+ GotoOrOpen call s:GotoOrOpen(<f-args>)

let g:fzf_action = {
  \ 'ctrl-t': 'GotoOrOpen tab',
  \ 'ctrl-s': 'split',
  \ 'ctrl-v': 'vsplit' }
let g:fzf_buffers_jump = 1
" If installed using git
set rtp+=~/.fzf


""" Tagbar ================================
" let g:tagbar_position = 'botright'


""" Tagline ================================
set tabline=%!MyTabLine()

function MyTabLine()
  let s = '' " complete tabline goes here
  " loop through each tab page
  for t in range(tabpagenr('$'))
    " set highlight
    let s .= '%#TabSep#'
    let s .= '  '

    if t + 1 == tabpagenr()
      let s .= '%#TabLineSel#'
    else
      let s .= '%#TabLine#'
    endif

    " set page number string
    let s .= t + 1 . ': '
    " get buffer names and statuses
    let n = ''      "temp string for buffer names while we loop and check buftype
    let m = 0       " &modified counter
    let bc = len(tabpagebuflist(t + 1))     "counter to avoid last ' '
    " loop through each buffer in a tab
    for b in tabpagebuflist(t + 1)
      " buffer types: quickfix gets a [Q], help gets [H]{base fname}
      " others get 1dir/2dir/3dir/fname shortened to 1/2/3/fname
      if getbufvar( b, "&buftype" ) == 'help'
        let n .= '[H]' . fnamemodify( bufname(b), ':t:s/.txt$//' )
      elseif getbufvar( b, "&buftype" ) == 'quickfix'
        let n .= '[Q]'
      else
        let n .= pathshorten(bufname(b))
      endif
      " check and ++ tab's &modified count
      if getbufvar( b, "&modified" )
        let m += 1
      endif
      " no final ' ' added...formatting looks better done later
      if bc > 1
        let n .= ' '
      endif
      let bc -= 1
    endfor
    " add modified label [n+] where n pages in tab are modified
    if m > 0
      let s .= '[' . m . '+]'
    endif
    " select the highlighting for the buffer names
    " my default highlighting only underlines the active tab
    " buffer names.
    if t + 1 == tabpagenr()
      let s .= '%#TabLineSel#'
    else
      let s .= '%#TabLine#'
    endif
    " add buffer names
    if n == ''
      let s.= '[New]'
    else
      let s .= n
    endif
    " switch to no underlining and add final space to buffer list
    let s .= ' '
  endfor
  " after the last tab fill with TabLineFill and reset tab page nr
  let s .= '%#TabLineFill#%T'
  " right-align the label to close the current tab page
  if tabpagenr('$') > 1
    let s .= '%=%#TabLineFill#%999Xclose'
  endif
  return s
endfunction
hi TabLine ctermfg=Black ctermbg=Green
hi TabLineSel ctermfg=Black ctermbg=Red
hi TabLineFill ctermfg=DarkGreen ctermbg=DarkGreen
hi TabSep ctermfg=Gray ctermbg=Gray

""" tmux integration ================================
function! TmuxMove(direction)
        let wnr = winnr()
        silent! execute 'wincmd ' . a:direction
        " If the winnr is still the same after we moved, it is the last pane
        if wnr == winnr()
    " The active vim window in inactive tmux pane should be dimmed
    set wincolor=WinInactive
                call system('tmux select-pane -' . tr(a:direction, 'phjkl', 'lLDUR'))
        end
endfunction

nnoremap <silent> <c-w>h :call TmuxMove('h')<cr>
nnoremap <silent> <c-w>j :call TmuxMove('j')<cr>
nnoremap <silent> <c-w>k :call TmuxMove('k')<cr>
nnoremap <silent> <c-w>l :call TmuxMove('l')<cr>

""" easymotion ================================
let g:EasyMotion_do_mapping = 0 " Disable default mappings
let g:EasyMotion_smartcase = 1
let g:EasyMotion_prompt = ">"
let g:EasyMotion_verbose = 0

""" mapping CR, space, <F1>, and BS ================================
function s:MapCR()
    if &ft == 'coq'
        nmap <CR> \cl
    elseif index(["qf"], &filetype) == -1
        nmap <CR> <Plug>(easymotion-overwin-line)
    else
        nunmap <CR>
    endif
endfunction
autocmd BufEnter * call s:MapCR()

function s:MapSpace()
    if &ft == 'coq'
        nmap <Space> \cj
    else
        "nmap <Space> <Plug>(easymotion-overwin-f)
        nnoremap <silent> <Space> za
    endif
endfunction
autocmd BufEnter * call s:MapSpace()

function s:MapBS()
    if &ft == 'coq'
        nmap <BS> \ck
    else
        nnoremap <BS> zc
    endif
endfunction
autocmd BufEnter * call s:MapBS()

function! MapF1()
  if &ft == 'markdown'
    nnoremap <silent> <F1> :TocToggle<CR>
  elseif &ft != 'qf'
    nnoremap <silent> <F1> :TagbarToggle<CR>
  endif
endfunction
autocmd BufEnter * call MapF1()



" folding
let g:foldrealsyntax = 'syntax'
autocmd BufEnter *.py let g:foldrealsyntax = 'indent'

let g:foldfashion=0
function ToggleFoldFashion()
    let g:foldfashion = (g:foldfashion + 1) % 3
    if g:foldfashion == 1
        set fdn=1
        let &fdm=g:foldrealsyntax
        echo '[FOLD] syntax, level 1'
    elseif g:foldfashion == 2
        set fdn=20
        let &fdm=g:foldrealsyntax
        echo '[FOLD] syntax, level max'
    elseif g:foldfashion == 0
        set fdm=manual
        set nofen
        echo '[FOLD] manual. retained fold, view with `zi`, clear with `zE`'
    endif
endfunction

set foldtext=MyFoldText()
function MyFoldText()
  let line = getline(v:foldstart)
  return line . ' ...... }'
endfunction
set fillchars=vert:\|

hi Folded ctermbg=black ctermfg=magenta cterm=bold

set fdo-=block

" dim inactive window
hi WindowInactive ctermbg=243
au VimEnter,WinNew,WinEnter   * set wincolor=
au WinLeave * set wincolor=WindowInactive


" bulk commenting / uncommenting
let s:doubleSlashCommentFts = ['c', 'cpp', 'java', 'rust']
let s:hashCommentFts = ['python', 'sh']
let s:quoteCommentFts = ['vim']

function s:MapVComment()
    if index(s:doubleSlashCommentFts, &ft) != -1
      " idk why but <C-_> is the real <C-/>
      vnoremap <silent> <C-_> :s@^@//<CR>
    elseif index(s:hashCommentFts, &ft) != -1
      vnoremap <silent> <C-_> :s@^@#<CR>
    elseif index(s:quoteCommentFts, &ft) != -1
      vnoremap <silent> <C-_> :s@^@"<CR>
    endif
endfunction
autocmd BufEnter * call s:MapVComment()

function s:MapVUncomment()
    if index(s:doubleSlashCommentFts, &ft) != -1
      " idk why but <C-_> is the real <C-/>
      vnoremap <silent> <C-?> :s@^//@<CR>
    elseif index(s:hashCommentFts, &ft) != -1
      vnoremap <silent> <C-?> :s@^#@<CR>
    elseif index(s:quoteCommentFts, &ft) != -1
      vnoremap <silent> <C-?> :s@^"@<CR>
    endif
endfunction
autocmd BufEnter * call s:MapVUncomment()


"   :map [[ ?{<CR>w99[{
"   :map ][ /}<CR>b99]}
"   :map ]] j0[[%/{<CR>
"   :map [] k$][%?}<CR>
"
"
