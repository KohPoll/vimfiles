" author: kong xiangpeng
" create date: 2012-01-01
" mail: kongxp920@gmail.com
" github: https://github.com/kohpoll 
" blog: http://www.cnblogs.com/kohpoll

" if exists('g:kohpoll_vimrc')
"     finish
" endif
" let g:kohpoll_vimrc = 1

set nocompatible

call pathogen#infect()

" {{{ Generals

let mapleader = ","
let maplocalleader = ","

" ���÷����
nnoremap <up> <nop>
nnoremap <down> <nop>
"nnoremap <left> <nop>
"nnoremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>
" ��j,k�ڳ��ı�ʱ��screen line�ƶ�(������file line)
nnoremap j gj
nnoremap k gk

" ��;�ȼ���:(�����command mode)
nnoremap ; :

" }}}

" {{{ Helper Function

" ��ȡ��ǰĿ¼
func! GetPWD()
  return substitute(getcwd(), "", "", "g")
endfunc

" �ر�ƥ���ַ�
func! ClosePair(char)
  if getline('.')[col('.') - 1] == a:char
    return "\<Right>"
  else
    return a:char
  endif
endfunc

" ������в鿴
func! ViewInBrowser(which)
  if has("win32")
    let l:browsers = {
      \"cr": "C:/Users/kongxp/AppData/Local/Google/Chrome/Application/chrome.exe",
      \"ie": "C:/Program Files/Internet Explorer/iexplore.exe",
      \"ff": "C:/Program Files/Mozilla Firefox/firefox.exe"
    \}

    let l:serverPath = "D:/AppServ/www/"

    let l:urlPrefix = "http://localhost.:8080/"

    let l:cmdPrefix = "!start "
    let l:cmdSuffix = "\<cr>"
  elseif has("mac")
    let l:browsers = {
      \"cr": "/Applications/Google Chrome.app/"
    \}

    let l:serverPath = "/Users/qiyao/Sites/"

    let l:urlPrefix = "http://localhost/~qiyao/"

    let l:cmdPrefix = "!open -a "
    let l:cmdSuffix = " --args -new-tab \<cr>"
  else
    echo "dose not support this os."
    finish
  endif

  let l:surroundQuote = "\""

  let l:filePath = expand("%:p")
  let l:filePath = substitute(l:filePath, "\\\\", "/", "g")

  let l:inServer = stridx(l:filePath, l:serverPath)

  if l:inServer != -1
    let l:filePath = substitute(l:filePath, l:serverPath, l:urlPrefix, "g")
  else
    let l:filePath = "file://" . l:filePath
  endif

  let l:filePath = l:surroundQuote . l:filePath . l:surroundQuote
  let l:browser = l:surroundQuote . l:browsers[a:which] . l:surroundQuote

  echo l:filePath

  exec ":silent " . l:cmdPrefix . l:browser . " " .l:filePath . l:cmdSuffix
endfunc

" ˢ��dns
func! RefreshSystemDNS()
  !start cmd /C ipconfig /flushdns
  syn on
endfunc

" ����git
func! RunGit()
  cd %:p:h "��cd�����༭�ļ���Ŀ¼
  !start cmd /C "D:\ProgramTool\Git\bin\sh.exe" --login -i
  syn on
endfunc

" }}}

" {{{ Shortcuts Mapping

" ��normal mode
inoremap jj <ESC>

" �˳�
nnoremap <leader>q :q<cr>

" omnicomplete��ȫ
inoremap <C-d> <C-x><C-o>

" ���ҹ���µ���(�ڵ�ǰ�ļ���)
nnoremap <leader>f :lv /<c-r>=expand("<cword>")<cr>/ %<cr>:lw<cr>

" �ƶ�(��ĩ����,�����հ�)
nnoremap H ^
nnoremap L g_
" ��ǰ������
nnoremap - ddp
" ��ǰ������
nnoremap _ ddkgPk

" �༭ (Y, C, D)
nnoremap Y y$

" �۵�
nnoremap <Space> za

" ��ҳ
nnoremap <CR> <C-f>
nnoremap <BS> <C-b>

" buffer
nnoremap <left> :bp<cr>
nnoremap <right> :bn<cr>

" tab(ģ��chrome���viminum)
nnoremap t :tabnew<cr>
nnoremap x :tabclose<cr>
nnoremap J :tabprevious<cr>
nnoremap K :tabnext<cr>

" window
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l
nnoremap <C-k> <C-w>k
nnoremap <C-j> <C-w>j
nnoremap <leader>v <C-w>v
nnoremap <leader>s <C-w>s

" ����ʱ���
nnoremap <f6> a<C-r>=strftime("%Y-%m-%d %I:%M:%S")<cr><Esc>
inoremap <f6> <C-r>=strftime("%Y-%m-%d %a %I:%M:%S")<cr>

" �е���ǰĿ¼
nnoremap <leader>cd :cd %:p:h<cr>

" ��ݱ༭vimrc
nnoremap <leader>ev :vsp $MYVIMRC<cr>
" ���source vimrc
nnoremap <leader>sv :source $MYVIMRC<cr>

if has("win32")
  " vimrc���༭��source֮
  autocmd! bufwritepost _vimrc source $MYVIMRC

  " ��ݱ༭hosts
  nnoremap <leader>h :vsp c:\windows\system32\drivers\etc\hosts<cr>
  " hosts���༭��ˢ��dns
  autocmd! bufwritepost hosts call RefreshSystemDNS()

  " ����git
  nnoremap <f4> :call RunGit()<cr>

  " ��������в鿴
  nnoremap <f3>ch :call ViewInBrowser("cr")<cr>
  nnoremap <f3>ff :call ViewInBrowser("ff")<cr>
  nnoremap <f3>ie :call ViewInBrowser("ie")<cr>
else
  " vimrc���༭��source֮
  autocmd! bufwritepost .vimrc source $MYVIMRC

  " ��������в鿴(Ĭ����chrome��)
  nnoremap <f3> :call ViewInBrowser("cr")<cr>
endif

" }}}

" {{{ User Interface & Color Scheme

if has('gui_running')
  " ֻ��ʾ�˵�
  set guioptions=mcr

  if has("win32")
    " ��󻯴���
    autocmd! GUIEnter * simalt ~x	
    " ��������
    set guifont=Inconsolata:h14:cANSI
    set guifontwide=YouYuan:h12:b:cGB2312
  endif

  if has("gui_macvim")
    " ��󻯴���
    set lines=999 columns=999
    " ��������
    set guifont=Monaco:h16
  endif
endif

" ��ɫ
if has("gui_running")
  set background=dark

  colorscheme ir_black
  autocmd! BufNewFile,BufRead,BufEnter,WinEnter * colorscheme ir_black

  " colorscheme railscasts
  " autocmd! BufNewFile,BufRead,BufEnter,WinEnter * colorscheme railscasts

  " colorscheme molokai
  " let g:molokai_original = 1
  " autocmd! BufNewFile,BufRead,BufEnter,WinEnter * colorscheme molokai
else
  colorscheme darkblue
endif

" ��֤�﷨����
syntax on

" }}}

" {{{ Edit

" �����ļ�����
filetype plugin indent on

" omnicomplete��ȫ����
autocmd! FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd! FileType css set omnifunc=csscomplete#CompleteCSS
autocmd! FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd! FileType php,phtml set omnifunc=phpcomplete#CompletePHP

" js�﷨����(֧��jquery)
autocmd! BufRead,BufNewFile *.js set syntax=jquery

" json�﷨����
autocmd! BufRead,BufNewFile *.json set filetype=json

" �Զ���ȫ����,����
" inoremap " ""<ESC>i
" inoremap ' ''<ESC>i
" inoremap ( ()<ESC>i
" inoremap { {}<ESC>i
" inoremap [ []<ESC>i
" inoremap ) <c-r>=ClosePair(')')<cr>
" inoremap } <c-r>=ClosePair('}')<cr>
" inoremap ] <c-r>=ClosePair(']')<cr>

" ����block����
vnoremap <Tab> >gv
vnoremap <S-Tab> <gv

" ����һ��༭��
nnoremap <C-s> :w<cr>
nnoremap <C-a> ggVGL

" ����ʱʹ��"very magic"
nnoremap / /\v

" }}}

" {{{ Environment

set fileformats=unix,dos

" ������ʷ��¼
set history=500

" ��ʹ��modeline
set modelines=0

" ��ȫѡ��
set completeopt=longest,menu
" �༭ʱ��ʾ(),{},[]���
set showmatch 

" ���ı�����
set wrap
set linebreak
" set scrolloff=3
set formatoptions=qrn1
set textwidth=80
set colorcolumn=85

" ��ǩҳ
set tabpagemax=10
set showtabline=2

" ����̨����
set noerrorbells
set novisualbell
set t_vb= "close visual bell

" �кźͱ��
set relativenumber " ��ʾ����к�
set ruler " ��ʾ��ǰλ��
set cursorline " ������ǰ��

" ������/״̬��
set title " ��ʾcommand title 
set wildmenu 
set laststatus=2 " ����ʾ״̬��
set showcmd " ״̬����ʾĿǰ��ִ�е�ָ��

" ��ʽ״̬�� {{{
augroup ft_statuslinecolor 
  autocmd!

  autocmd InsertEnter * hi StatusLine ctermfg=196 guifg=#FF3145
  autocmd InsertLeave * hi StatusLine ctermfg=130 guifg=#CD5907
augroup END

set statusline=%{SyntasticStatuslineFlag()} " syntax error
set statusline+=%F   " Path.
set statusline+=%m   " Modified flag.
set statusline+=%r   " Readonly flag.
set statusline+=%w   " Preview window flag.

set statusline+=[
set statusline+=%{GetPWD()}
set statusline+=]

set statusline+=%=   " Right align.
" File format, encoding and type.  Ex: "(unix/utf-8/python)"
set statusline+=(
set statusline+=%{&ff}                        " Format (unix/DOS).
set statusline+=/
set statusline+=%{strlen(&fenc)?&fenc:&enc}   " Encoding (utf-8).
set statusline+=/
set statusline+=%{&ft}                        " Type (python).
set statusline+=)

" Line and column position and counts.
set statusline+=\ (%l\/%L,\ %v) 
"}}}

" ����ѡ��
set magic     " Set magic on, for regular expressions
set incsearch
set hlsearch  
set ignorecase
set smartcase
nnoremap <leader><space> :noh<cr>

" ����
set smarttab
set expandtab
set tabstop=2
set shiftwidth=2
set softtabstop=2
set autoindent
set smartindent

" �Զ����¶���
set autoread

" ����/����
set nobackup
set noswapfile

" �Զ�����Ŀ¼Ϊ���ڱ༭�ļ���Ŀ¼
"set autochdir

" ����ģʽ��ʹ�� <BS>��<Del> <C-W> <C-U>
set backspace=indent,eol,start

" �κ�ģʽ��������
set mouse=a

" �����۵���ʽ
set foldmethod=marker

" ��������
set encoding=utf-8 "vim�ڲ�����
set fileencodings=ucs-bom,utf-8,chinese "vim�����ļ�ʱ���Եı���˳��
" �ļ�����
if has("win32")  
  set fileencoding=chinese  
else  
  set fileencoding=utf-8  
endif  

" ������Ĳ˵�����
set langmenu=zh_CN.utf-8  
source $VIMRUNTIME/delmenu.vim  
source $VIMRUNTIME/menu.vim  
language messages zh_cn.utf-8
" ��˫�ֽڴ��������ַ�
if v:lang =~? '^\(zh\)\|\(ja\)\|\(ko\)'
  set ambiwidth=double
endif
set nobomb "�������ֽ�����

" }}}

" {{{ Plugin

" supertab.vim
" tab����ȫ

" snipmate.vim
" �ո��-Ƭ��չ��
" inoremap <space> <c-r>=TriggerSnippet()<cr>

" syntastic.vim
" �﷨���
" ���Զ���飬�ֶ����
let g:syntastic_mode_map = { 'mode': 'passive',
                           \ 'active_filetypes': [],
                           \ 'passive_filetypes': [] }

" TComment.vim
" gc(toggle comment selected), gcc(toggle comment current line)

" surround.vim
" ds(target), 
" cs(target)(replacement), 
" ys(motion|target)(surrounding), yS, yss, ySS

" repeat.vim
" make some(e.g: surround) actions repeatable with .

" ragtag.vim
" ctrl-x /(�պϱ�ǩ); ctrl-x space, ctrl-x enter(���ɱ�ǩ)
let g:ragtag_global_maps = 1

" zencoding.vim
" ctrl-e ,
let g:user_zen_leader_key = '<C-e>'
let g:use_zen_complete_tag = 1

" Fencview.vim
" iconv.dll��$PATH��
let g:fencview_autodetect = 0
nnoremap <f2> :FencView<cr>

" NERDTree.vim
nnoremap <f8> :NERDTreeToggle<cr>
let NERDTreeIgnore = ['\.pyc$', '\.svn$', '\.tmp$', '\.bak', '\~$', '\.swp$', 'Thumbs\.db']
let NERDTreeQuitOnOpen = 0
" let NERDTreeDirArrows = 1

" }}}

" {{{ Personal

if has("win32")
  cd D:\
endif

" }}}
