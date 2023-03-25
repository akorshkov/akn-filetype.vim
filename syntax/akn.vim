
" syntax of headers
syntax match AknHeader1 "^= \+.* \+=$" contains=AknHeaderBorder
syntax match AknHeader2 "^== \+.* \+==$" contains=AknHeaderBorder
syntax match AknHeader3 "^=== \+.* \+===$" contains=AknHeaderBorder
syntax match AknHeader4 "^==== \+.* \+====$" contains=AknHeaderBorder
syntax match AknHeader5 "^===== \+.* \+=====$" contains=AknHeaderBorder
syntax match AknHeader6 "^====== \+.* \+======$" contains=AknHeaderBorder

syntax match AknHeaderBorder "=\{1,6}" contained

" syntax of note lines
syntax region AknNoteLine start="^> " end="$"
syntax region AknNote1Line start="^>> " end="$"

" syntax of arrow notes
syntax region AknArrowNote start="<- " end="$"
syntax region AknArrowNote start="<-$" end="$"
syntax region AknArrowNote1 start="<-! " end="$"
syntax region AknArrowNote1 start="<-!$" end="$"

" syntax of list indicators
syntax match AknListIndicatorDash "^ *- "
syntax match AknListIndicatorStar "^ *\* "
syntax match AknListIndicatorNumber "\v^ *[0-9.]+\. "


" highlight groups

" 
hi! def link AknHeader1 Title
hi! def link AknHeader2 Special
hi! def link AknHeader3 Constant
hi! def link AknHeader4 Directory
hi! def link AknHeader5 String
hi! def link AknHeader6 Comment
hi! def link AknHeaderBorder Normal
" highlight link AknHeaderBorder ErrorMsg

if hlexists("DiagnosticError")
  " highliting for nvim (there are more standard hl-groups in nvim than in vim)
  hi! def link AknNoteLine String
  hi! def link AknNote1Line Question
  hi! def link AknArrowNote Comment
  hi! def link AknArrowNote1 DiagnosticError
else
  " highliting for vim
  hi! def link AknNoteLine String
  hi! def link AknNote1Line Question
  hi! def link AknArrowNote Comment
  hi! def link AknArrowNote1 ErrorMsg
endif

hi! def link AknListIndicatorDash Identifier
hi! def link AknListIndicatorStar Identifier
hi! def link AknListIndicatorNumber Identifier
