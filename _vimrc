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

" 不用方向键
nnoremap <up> <nop>
nnoremap <down> <nop>
"nnoremap <left> <nop>
"nnoremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>
" 让j,k在长文本时以screen line移动(而不是file line)
nnoremap j gj
nnoremap k gk

" 让;等价于:(方便进command mode)
nnoremap ; :

" }}}

" {{{ Helper Function

" 获取当前目录
func! GetPWD()
  return substitute(getcwd(), "", "", "g")
endfunc

" 关闭匹配字符
func! ClosePair(char)
  if getline('.')[col('.') - 1] == a:char
    return "\<Right>"
  else
    return a:char
  endif
endfunc

" 浏览器中查看
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

" 刷新dns
func! RefreshSystemDNS()
  !start cmd /C ipconfig /flushdns
  syn on
endfunc

" 启动git
func! RunGit()
  cd %:p:h "先cd到所编辑文件的目录
  !start cmd /C "D:\ProgramTool\Git\bin\sh.exe" --login -i
  syn on
endfunc

" }}}

" {{{ Shortcuts Mapping

" 回normal mode
inoremap jj <ESC>

" 退出
nnoremap <leader>q :q<cr>

" omnicomplete补全
inoremap <C-d> <C-x><C-o>

" 查找光标下单词(在当前文件中)
nnoremap <leader>f :lv /<c-r>=expand("<cword>")<cr>/ %<cr>:lw<cr>

" 移动(行末行首,不含空白)
nnoremap H ^
nnoremap L g_
" 当前行下移
nnoremap - ddp
" 当前行上移
nnoremap _ ddkgPk

" 编辑 (Y, C, D)
nnoremap Y y$

" 折叠
nnoremap <Space> za

" 滚页
nnoremap <CR> <C-f>
nnoremap <BS> <C-b>

" buffer
nnoremap <left> :bp<cr>
nnoremap <right> :bn<cr>

" tab(模仿chrome插件viminum)
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

" 插入时间戳
nnoremap <f6> a<C-r>=strftime("%Y-%m-%d %I:%M:%S")<cr><Esc>
inoremap <f6> <C-r>=strftime("%Y-%m-%d %a %I:%M:%S")<cr>

" 切到当前目录
nnoremap <leader>cd :cd %:p:h<cr>

" 快捷编辑vimrc
nnoremap <leader>ev :vsp $MYVIMRC<cr>
" 快捷source vimrc
nnoremap <leader>sv :source $MYVIMRC<cr>

if has("win32")
  " vimrc被编辑后，source之
  autocmd! bufwritepost _vimrc source $MYVIMRC

  " 快捷编辑hosts
  nnoremap <leader>h :vsp c:\windows\system32\drivers\etc\hosts<cr>
  " hosts被编辑后，刷新dns
  autocmd! bufwritepost hosts call RefreshSystemDNS()

  " 启动git
  nnoremap <f4> :call RunGit()<cr>

  " 在浏览器中查看
  nnoremap <f3>ch :call ViewInBrowser("cr")<cr>
  nnoremap <f3>ff :call ViewInBrowser("ff")<cr>
  nnoremap <f3>ie :call ViewInBrowser("ie")<cr>
else
  " vimrc被编辑后，source之
  autocmd! bufwritepost .vimrc source $MYVIMRC

  " 在浏览器中查看(默认用chrome开)
  nnoremap <f3> :call ViewInBrowser("cr")<cr>
endif

" }}}

" {{{ User Interface & Color Scheme

if has('gui_running')
  " 只显示菜单
  set guioptions=mcr

  if has("win32")
    " 最大化窗口
    autocmd! GUIEnter * simalt ~x	
    " 字体配置
    set guifont=Inconsolata:h14:cANSI
    set guifontwide=YouYuan:h12:b:cGB2312
  endif

  if has("gui_macvim")
    " 最大化窗口
    set lines=999 columns=999
    " 字体配置
    set guifont=Monaco:h16
  endif
endif

" 配色
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

" 保证语法高亮
syntax on

" }}}

" {{{ Edit

" 开启文件类型
filetype plugin indent on

" omnicomplete补全设置
autocmd! FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd! FileType css set omnifunc=csscomplete#CompleteCSS
autocmd! FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd! FileType php,phtml set omnifunc=phpcomplete#CompletePHP

" js语法高亮(支持jquery)
autocmd! BufRead,BufNewFile *.js set syntax=jquery

" json语法高亮
autocmd! BufRead,BufNewFile *.json set filetype=json

" 自动补全括号,引号
" inoremap " ""<ESC>i
" inoremap ' ''<ESC>i
" inoremap ( ()<ESC>i
" inoremap { {}<ESC>i
" inoremap [ []<ESC>i
" inoremap ) <c-r>=ClosePair(')')<cr>
" inoremap } <c-r>=ClosePair('}')<cr>
" inoremap ] <c-r>=ClosePair(']')<cr>

" 方便block缩进
vnoremap <Tab> >gv
vnoremap <S-Tab> <gv

" 兼容一般编辑器
nnoremap <C-s> :w<cr>
nnoremap <C-a> ggVGL

" 搜索时使用"very magic"
nnoremap / /\v

" }}}

" {{{ Environment

set fileformats=unix,dos

" 保留历史记录
set history=500

" 不使用modeline
set modelines=0

" 补全选项
set completeopt=longest,menu
" 编辑时显示(),{},[]配对
set showmatch 

" 长文本处理
set wrap
set linebreak
" set scrolloff=3
set formatoptions=qrn1
set textwidth=80
set colorcolumn=85

" 标签页
set tabpagemax=10
set showtabline=2

" 控制台响铃
set noerrorbells
set novisualbell
set t_vb= "close visual bell

" 行号和标尺
set relativenumber " 显示相对行号
set ruler " 显示当前位置
set cursorline " 高亮当前行

" 命令行/状态行
set title " 显示command title 
set wildmenu 
set laststatus=2 " 总显示状态行
set showcmd " 状态行显示目前所执行的指令

" 格式状态栏 {{{
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

" 搜索选项
set magic     " Set magic on, for regular expressions
set incsearch
set hlsearch  
set ignorecase
set smartcase
nnoremap <leader><space> :noh<cr>

" 缩进
set smarttab
set expandtab
set tabstop=2
set shiftwidth=2
set softtabstop=2
set autoindent
set smartindent

" 自动重新读入
set autoread

" 备份/缓存
set nobackup
set noswapfile

" 自动设置目录为正在编辑文件的目录
"set autochdir

" 插入模式下使用 <BS>、<Del> <C-W> <C-U>
set backspace=indent,eol,start

" 任何模式下鼠标可用
set mouse=a

" 代码折叠方式
set foldmethod=marker

" 编码设置
set encoding=utf-8 "vim内部编码
set fileencodings=ucs-bom,utf-8,chinese "vim解析文件时测试的编码顺序
" 文件编码
if has("win32")  
  set fileencoding=chinese  
else  
  set fileencoding=utf-8  
endif  

" 解决中文菜单乱码
set langmenu=zh_CN.utf-8  
source $VIMRUNTIME/delmenu.vim  
source $VIMRUNTIME/menu.vim  
language messages zh_cn.utf-8
" 以双字节处理特殊字符
if v:lang =~? '^\(zh\)\|\(ja\)\|\(ko\)'
  set ambiwidth=double
endif
set nobomb "不设置字节序标记

" }}}

" {{{ Plugin

" supertab.vim
" tab键补全

" snipmate.vim
" 空格键-片段展开
" inoremap <space> <c-r>=TriggerSnippet()<cr>

" syntastic.vim
" 语法检查
" 不自动检查，手动检查
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
" ctrl-x /(闭合标签); ctrl-x space, ctrl-x enter(生成标签)
let g:ragtag_global_maps = 1

" zencoding.vim
" ctrl-e ,
let g:user_zen_leader_key = '<C-e>'
let g:use_zen_complete_tag = 1

" Fencview.vim
" iconv.dll在$PATH中
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
