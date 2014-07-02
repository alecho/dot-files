"
"
"

set background=dark
highlight clear
if exists("syntax_on") 
  syntax reset
endif
let g:colors_name = "Afterglow"

" Backgrounds

" Line Numbers
:hi LineNr ctermfg=8

" Comments
highlight comment ctermfg=8

" Syntax
highlight string ctermfg=11
highlight special ctermfg=10
highlight type ctermfg=9 
highlight Statement ctermfg=13
highlight Operator ctermfg=12
highlight Delimiter ctermfg=7
highlight phpDefine ctermfg=12
highlight phpRegion ctermfg=10
highlight Identifier ctermfg=15
" highlight Function:Identifier ctermfg=9
