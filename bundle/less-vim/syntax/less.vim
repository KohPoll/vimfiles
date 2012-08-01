" Vim syntax fle
" Language: Less
" Author: Kohpoll (http://www.cnblogs.com/kohpoll/)
" Inspired by the syntax files of scss and css.
" Licensed under MIT.
" Last Modified: 2012-03-12

if exists("b:current_syntax") && b:current_syntax == "less"
  finish
endif

" use the css syntax
runtime! syntax/css.vim

syn case ignore


syn cluster lessCssProperties contains=css.*Prop
syn cluster lessCssAttributes contains=css.*Attr,cssValue.*,cssColor,cssURL,cssImportant,cssErr,cssStringQ,cssStringQQ,lessComment

syn region lessDefinition matchgroup=cssBraces start='{' end='}' contains=TOP

" hs=s+1
syn match lessProperty "\%([{};]\s*\|^\)\@<=\%([[:alnum:]-]\)\+\s*:" contains=css.*Prop skipwhite nextgroup=lessCssAttribute contained containedin=lessDefinition
syn match lessProperty "^\s*\zs\s\%(\%([[:alnum:]-]\)\+\s*:\|:[[:alnum:]-]\+\)"hs=s+1 contains=css.*Prop skipwhite nextgroup=lessCssAttribute

syn match lessCssAttribute +\%("\%([^"]\|\\"\)*"\|'\%([^']\|\\'\)*'\|[^{};]\)*+ contained contains=@lessCssAttributes,lessVariable,lessFunction,lessInterpolation

syn match lessVariable "@\{1,2}[[:alnum:]_-]\+"
syn match lessVariableAssignment "\%(@\{1,2}[[:alnum:]_-]\+\s*\)\@<=:" nextgroup=lessCssAttribute skipwhite
hi def link lessVariable Identifier

syn match lessAmpersand "&"
hi def link lessAmpersand Character

syn region lessInclude start="@import" end=";\|$"me=e-1 contains=lessComment,cssStringQ,cssStringQQ,cssURL,cssUnicodeEscape,cssMediaType
hi def link lessInclude Include

"me=e-1 means that the last char of the pattern is not highlighted(i.e: ;)
syn region lessInterpolation matchgroup=lessInterpolationDelimiter start="@{" end="}" contains=@lessCssAttributes,lessVariable,lessFunction containedin=cssStringQ,cssStringQQ,cssPseudoClass,lessProperty
syn region lessInterpolation matchgroup=lessInterpolationDelimiter start="%(" end=");"me=e-1 contains=@lessCssAttributes,lessVariable,lessFunction,cssStringQ,cssStringQQ
hi def link lessInterpolationDelimiter Constant

syn keyword lessFunction lighten darken saturate desaturate fadein fadeout fade mix spin hsl hue saturation lightness contained 
syn keyword lessFunction round ceil floor percentage contained
hi def link lessFunction Function

syn keyword lessTodo        FIXME NOTE TODO OPTIMIZE XXX contained
syn region  lessComment     start="^\z(\s*\)//"  end="^\%(\z1 \)\@!" contains=lessTodo,@Spell
syn region  lessCssComment  start="^\z(\s*\)/\*" end="^\%(\z1 \)\@!" contains=lessTodo,@Spell
hi def link lessCssComment lessComment
hi def link lessComment Comment
hi def link lessTodo Todo

if !exists("b:current_syntax")
  let b:current_syntax = "less"
endif

" 1.0
" - First version.May be problems here and there.
" - FIX:I can not find ways to exactly define mixin(e.g: .mixinName) and namespace(e.g: #bundle > .util), as they are just the same as class and id of css selector.
