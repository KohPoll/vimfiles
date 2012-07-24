个人的vim配置~


`if` in windows

  `cd` 到vim安装目录
  `git clone https://github.com/KohPoll/vimfiles.git`

  `cd` 到vimfilels目录
  `git submodule init`

  `git submodule update`

  将_vimrc放在vim安装目录下

  将vim安装目录\vimfiles\lib加入系统PATH变量
  
`else`

  `cd` 到用户目录
  `git clone https://github.com/KohPoll/vimfiles.git`

  `cd` 到vimfilels目录
  `git submodule init`

  `git submodule update`

  将_vimrc重名为.vimrc, 放在用户目录(或者做个链接?)

  将vimfiles重命名为.vim
