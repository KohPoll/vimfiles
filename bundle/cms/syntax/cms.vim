" Vim syntax file
"

if version < 600
  syntax clear
elseif exists("b:current_syntax")
  finish
endif

if !exists("main_syntax")
  let main_syntax = 'cms'
endif

ru! syntax/html.vim
unlet b:current_syntax


syn match cmsDirective "\v#set"
syn match cmsDirective "\v#if"
syn match cmsDirective "\v#else(if)?"
syn match cmsDirective "\v#foreach"
syn match cmsDirective "\v#end"

syn match cmsReference "\v\$!?\{?\w+\}?"

syn match cmsInternalVariable "\v\$velocityCount"
syn match cmsInternalVariable "\v\$repeatCount"

syn match htmlTagName contained "\vcms:text(Area|Link)?"
syn match htmlTagName contained "\vcms:image(Link)?"
syn match htmlTagName contained "\vcms:(product|custom|repeat)"

syn keyword htmlArg contained group row defaultRow fields

highlight link cmsDirective Identifier
highlight link cmsReference Special
highlight link cmsInternalVariable Keyword


let b:current_syntax = "cms"

if main_syntax == 'cms'
  unlet main_syntax
endif
