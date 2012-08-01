if exists("b:did_ftplugin")
  finish
endif

let b:did_ftplugin = 1

" Enable LessMake if it won't overwrite any settings.
" if !len(&l:makeprg)
"   compiler less
" endif

"编译当前less文件，保存为同名的css文件，将错误echo显示
func! s:CompileLess()
    let l:input = fnameescape(expand("%:p"))
    let l:output = fnameescape(expand("%:p:r") . ".css")

    let l:cmd = "lessc " . l:input . " " . l:output

    let l:errs = system(l:cmd)

    if (!empty(l:errs))
      let l:errs = substitute(l:errs, "\\%o033[\\d\\+m", "", "g") 
      let l:errs = substitute(l:errs, "^$", "", "g")
      let l:errs = split(l:errs, "\\n")[0]
      echo l:errs
    endif
endfunc

" 自动编译less
autocmd! BufWritePost,FileWritePost *.less call s:CompileLess()
