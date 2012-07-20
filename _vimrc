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
    let l:browser = {
        \"cr": "C:/Users/kongxp/AppData/Local/Google/Chrome/Application/chrome.exe ",
        \"ie": "C:/Program Files/Internet Explorer/iexplore.exe ",
        \"ff": "C:/Program Files/Mozilla Firefox/firefox.exe "
    \}

    let l:filePath = expand("%:p")

    let l:inServer = stridx(l:filePath, "d:\\appserv\\www\\")
    if l:inServer != -1
        let l:filePath = substitute(l:filePath, "D:\\\\appserv\\\\www\\\\", "http://localhost.:8080/", "g")
        let l:filePath = substitute(l:filePath, "\\\\", "/", "g")
    endif

    echo l:filePath

    exec ":silent !start " . l:browser[a:which] . l:filePath . "\<cr>"
endfunc

" ����less(ʹ��windows�µ�lessjs)
func! CompileLess()
    let l:filePath = shellescape(expand("%:p"))
    let l:outputFilePath = shellescape(expand("%:p:r") . ".css")

    let l:cmd = "lessc " . l:filePath . " " . l:outputFilePath

    let l:errs = system(l:cmd)

    echo l:errs
    " if (strlen(l:errs) > 0) 
        " write quickfix errors to a temp file 
        " let l:tmpFile = tempname()
        " execute "redir! > " . tmpFile
        " silent echon errs
        " redir END

        " " read in the errors temp file 
        " execute "silent! cfile " . tmpFile

        " " open the quicfix window
        " "botright copen
        " let s:qfix_buffer = bufnr("$")

        " " delete the temp file
        " call delete(tmpFile)
    " endif

    " exec ":silent !start " . l:lesscPath . l:filePath . " " . l:outputFilePath . "\<cr>"
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

" ���ҹ���µ���(�ڵ�ǰ�ļ���)
nnoremap <leader>f :lv /<c-r>=expand("<cword>")<cr>/ %<cr>:lw<cr>

" �ƶ�
nnoremap H 0
nnoremap L $

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

" ��������в鿴
nnoremap <f3>ch :call ViewInBrowser("cr")<cr>
nnoremap <f3>ff :call ViewInBrowser("ff")<cr>
nnoremap <f3>ie :call ViewInBrowser("ie")<cr>

" ����git
nnoremap <f4> :call RunGit()<cr>

" �е���ǰĿ¼
nnoremap <leader>cd :cd %:p:h<cr>

" ��ݱ༭vimrc
nnoremap <leader>rc :vsp $VIM\_vimrc<cr>
" ���source vimrc
nnoremap <leader>src :source $VIM\_vimrc<cr>
" vimrc���༭��source֮
autocmd! bufwritepost _vimrc source $VIM\_vimrc

" ��ݱ༭hosts
nnoremap <leader>h :vsp c:\windows\system32\drivers\etc\hosts<cr>
" hosts���༭��ˢ��dns
autocmd! bufwritepost hosts call RefreshSystemDNS()

" }}}

" {{{ User Interface & Color Scheme

if has('gui_running')
    " ֻ��ʾ�˵�
    set guioptions=mcr

    if has("win32")
      " ��󻯴���
      autocmd! GUIEnter * simalt ~x	

      " ��������
      exec 'set guifont='.iconv('Consolas', &enc, 'gbk').':h12:cANSI'
      "exec 'set guifontwide='.iconv('Microsoft\ YaHei', &enc, 'gbk').':h14'
    endif
endif

" ��ɫ

set background=dark

" colorscheme molokai
" let g:molokai_original = 1
" autocmd! BufNewFile,BufRead,BufEnter,WinEnter * colorscheme molokai

colorscheme railscasts
autocmd! BufNewFile,BufRead,BufEnter,WinEnter * colorscheme railscasts

" ��֤�﷨����
syntax on

" }}}

" {{{ Edit

" �����ļ�����
filetype plugin indent on

" �Զ�����less
autocmd! BufWritePost,FileWritePost *.less call CompileLess()

" �Զ�����coffee
autocmd! BufWritePost,FileWritePost *.coffee silent CoffeeMake! | cwindow | redraw!

" js�﷨����(֧��jquery)
autocmd! BufRead,BufNewFile *.js set syntax=jquery

" json�﷨����
autocmd! BufRead,BufNewFile *.json set filetype=json

" less֧��
autocmd! BufRead,BufNewFile *.less set filetype=less

" ����html�е�php(phtml.vim)
autocmd! BufRead,BufNewFile *.php set filetype=phtml

" �Զ���ȫ����,����
"inoremap " ""<ESC>i
"inoremap ' ''<ESC>i
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

set statusline=%F    " Path.
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
set showmatch 
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
set fileencodings=ucs-bom,utf-8,chinese,latin-1 "vim�����ļ�ʱ���Եı���˳��
" set fileencodings=utf-8,gbk,ucs-bom,gb18030,gb2312,cp936,latin1
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

" TComment.vim
" gc(toggle comment selected), gcc(toggle comment current line)

" surround.vim
" ds(target), 
" cs(target)(replacement), 
" ys(motion|target)(surrounding), yS, yss, ySS

" repeat.vim
" make some(e.g: surround) actions repeatable with .

" ragtag.vim
" ctrl-x /, ctrl-x space, ctrl-x enter
let g:ragtag_global_maps = 1

" supertab.vim
let g:SuperTabRetainCompletionDuration = 'session' "��ס�ϴ�ʹ�õĲ�ȫ��ʽ,ֱ���˳�vim��ѡ��������Ĳ�ȫ��ʽ

" zencoding.vim
let g:user_zen_leader_key = '<C-e>'
let g:use_zen_complete_tag = 1

" Fencview.vim
" iconv.dll��$PATH��
let g:fencview_autodetect = 0
nnoremap <f2> :FencView<cr>

" NERDTree.vim
nnoremap <f9> :NERDTreeToggle<cr>
let NERDTreeIgnore = ['\.pyc$', '\.svn$', '\.tmp$', '\.bak', '\~$', '\.swp$', 'Thumbs\.db']
let NERDTreeQuitOnOpen = 0

" }}}

" {{{ Other

" cd to d
cd d:\

" }}}
