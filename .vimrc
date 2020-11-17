""" vim-plug
"plug: call plug#begin('~/.vim/bundle')
"plug: Plug 'junegunn/vim-easy-align'
"plug: Plug 'vim-scripts/DrawIt'
"plug: Plug 'whonore/Coqtail' | Plug 'let-def/vimbufsync'
"plug: Plug 'majutsushi/tagbar'
"plug: Plug 'vim-scripts/CmdlineComplete'
"plug: Plug 'easymotion/vim-easymotion'
"plug: set rtp+=~/.fzf " fzf
"plug: " highlights
"plug: Plug 'pest-parser/pest.vim'
"plug: Plug 'mlr-msft/vim-loves-dafny'
"plug: Plug 'derekwyatt/vim-scala'
"plug: Plug 'plasticboy/vim-markdown'
"plug: Plug 'jrozner/vim-antlr'
"plug: Plug 'rust-lang/rust.vim'
"plug: "#Plug '~/.vim/bundle/vim-why3'
"plug: Plug '~/.vim/bundle/grammarspec'
"plug: Plug 'leafgarland/typescript-vim'
"plug: call plug#end()

filetype plugin indent on

set nocompatible
behave xterm
syntax on
syntax enable
colorscheme default
set background=dark


""" set's ****************************************
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4

set nobackup
set nowritebackup
set noswapfile
set noundofile

set backspace=indent,eol,start
set autoindent
set hlsearch

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
command T tabe


""" map's ****************************************
map <F2> :w<CR>
imap <F2> <C-O>:w<CR>
map <F3> :nohlsearch<CR>
map <F5> :e<CR>
nnoremap <Tab> gt
nnoremap <S-Tab> gT
noremap <C-H> :su///g<Left><Left><Left>
noremap <C-J> :%su///g<Left><Left><Left>
noremap K yiw:%s/\<<C-R>"\>//g<Left><Left>
noremap Y y$
imap {<CR> {<CR>}<C-O>O
imap , ,<Space>
inoremap <C-E> <C-X><C-E>
inoremap <C-Y> <C-X><C-Y>
" use Ctrl+C and Ctrl+V to work with system clipboards
vmap <C-c> "+Y
nmap <C-v> "+p
nnoremap <C-Q> <C-V>
nmap . @q

""" abbreviations ================================

""" highlights ================================
highlight MyBreak cterm=bold term=bold ctermfg=white ctermbg=2
match MyBreak /\(=\{20}=\+\|-\{20}-\+\)/

hi StatusLine	gui=bold	guifg=red	guibg=blue	ctermfg=magenta   ctermbg=blue

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

function! s:SetTabs(a)
  let &tabstop=str2nr(a:a)
  let &softtabstop=str2nr(a:a)
  let &shiftwidth=str2nr(a:a)
endfunction
command! -nargs=1 TT call s:SetTabs(<args>)

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

" easy align
"plug: nmap <C-s> <Plug>(EasyAlign)
"plug: xmap <C-s> <Plug>(EasyAlign)
"plug: let g:easy_align_ignore_groups = ['String']

" markdown
"plug: let g:vim_markdown_folding_disabled = 1
"plug: let g:tex_conceal = ""
"plug: let g:vim_markdown_math = 1
"plug: let g:vim_markdown_auto_insert_bullets = 0
"plug: let g:vim_markdown_new_list_item_indent = 0
"plug: let g:vim_markdown_toc_autofit = 1
"plug: " :autocmd BufReadPost *.md :Toc

" fzf
"plug: nnoremap <silent> <C-p> :FZF<CR>
"plug: 
"plug: function! s:GotoOrOpen(command, ...)
"plug:   for file in a:000
"plug:     if a:command == 'e'
"plug:       exec 'e ' . file
"plug:     else
"plug:       exec "tab drop " . file
"plug:     endif
"plug:   endfor
"plug: endfunction
"plug: command! -nargs=+ GotoOrOpen call s:GotoOrOpen(<f-args>)
"plug: 
"plug: let g:fzf_action = {
"plug:   \ 'ctrl-t': 'GotoOrOpen tab',
"plug:   \ 'ctrl-x': 'split',
"plug:   \ 'ctrl-v': 'vsplit' }
"plug: let g:fzf_buffers_jump = 1
"plug: " If installed using git
"plug: set rtp+=~/.fzf

""" Tagbar ================================
"plug: nmap <F1> :TagbarToggle<CR>
"plug: let g:tagbar_left = 1

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
                call system('tmux select-pane -' . tr(a:direction, 'phjkl', 'lLDUR'))
        end
endfunction

nnoremap <silent> <c-w>h :call TmuxMove('h')<cr>
nnoremap <silent> <c-w>j :call TmuxMove('j')<cr>
nnoremap <silent> <c-w>k :call TmuxMove('k')<cr>
nnoremap <silent> <c-w>l :call TmuxMove('l')<cr>

""" easymotion ================================
"plug: let g:EasyMotion_do_mapping = 0 " Disable default mappings
"plug: let g:EasyMotion_smartcase = 1
"plug: let g:EasyMotion_prompt = ">"
"plug: let g:EasyMotion_verbose = 0

""" coqtail: mapping CR space and BS ================================
"plug: function MapCR()
"plug:     if &ft == 'coq'
"plug:         nmap <CR> \cl
"plug:     else
"plug:         nmap <CR> <Plug>(easymotion-overwin-line)
"plug:     endif
"plug: endfunction
"plug: autocmd BufEnter * call MapCR()
"plug: 
"plug: function MapSpace()
"plug:     if &ft == 'coq'
"plug:         nmap <Space> \cj
"plug:     else
"plug:         nmap <Space> <Plug>(easymotion-overwin-f)
"plug:     endif
"plug: endfunction
"plug: autocmd BufEnter * call MapSpace()
"plug: 
"plug: function MapBS()
"plug:     if &ft == 'coq'
"plug:         nmap <BS> \ck
"plug:     endif
"plug: endfunction
"plug: autocmd BufEnter * call MapBS()

""" per-window search pattern & marking ================================
"let s:searches={}
"let s:matches={}
"hi MyMark term=reverse ctermfg=0 ctermbg=6 guifg=Black guibg=Cyan
"au WinLeave * call s:Mark(@/)
"au WinNew   * let idx=tabpagenr()*100+winnr() |
"            \ let s:searches[idx]=""
"au WinEnter * call clearmatches() |
"	    \ let idx=tabpagenr()*100+winnr() |
"            \ let @/=s:searches[idx] |
"	    \ call feedkeys('\<BS>n')
"function! s:Mark(ptn)
"	call clearmatches()
"	let idx=tabpagenr()*100+winnr()
"	let s:searches[idx]=a:ptn
"        call matchadd('MyMark', s:searches[idx], 11)
"endfunction
