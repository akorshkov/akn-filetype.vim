
" syntax of headers
syntax match AknHeader1 "^= \+.* \+=$" contains=AknHeaderBorder
syntax match AknHeader2 "^== \+.* \+==$" contains=AknHeaderBorder
syntax match AknHeader3 "^=== \+.* \+===$" contains=AknHeaderBorder
syntax match AknHeader4 "^==== \+.* \+====$" contains=AknHeaderBorder
syntax match AknHeader5 "^===== \+.* \+=====$" contains=AknHeaderBorder
syntax match AknHeader6 "^====== \+.* \+======$" contains=AknHeaderBorder

syntax match AknHeaderBorder "=\{1,6}" contained

" syntax of note marks: smthn like (!!!) in note lines
syntax match AknNoteMark3 "(!!!)" contained
syntax match AknNoteMark "(!)" contained

" syntax of note lines
syntax region AknNoteLine start="^> " end="$" contains=AknNoteMark,AknNoteMark3
syntax region AknNote1Line start="^>> " end="$" contains=AknNoteMark,AknNoteMark3
syntax region AknNote2Line start="^>! " end="$" contains=AknNoteMark,AknNoteMark3

" syntax of arrow notes
syntax region AknArrowNote start="<- " end="$" contains=AknNoteMark,AknNoteMark3
syntax region AknArrowNote start="<-$" end="$"
syntax region AknArrowNote1 start="<! " end="$" contains=AknNoteMark,AknNoteMark3
syntax region AknArrowNote1 start="<!$" end="$"

" syntax of bash snippets
syntax region AknBashLine start="^\$ " end="$" contains=AknArrowNote,AknArrowNote1

" syntax of list indicators
syntax match AknListIndicatorDash "^ *- "
syntax match AknListIndicatorStar "^ *\* "
syntax match AknListIndicatorNumber "^ *[0-9.]\+\. "

" syntax of terms table
syntax match AknTermColon ": " contained
syntax match AknTerm "^ *\w\+ *: " contains=AknTermColon
syntax match AknTermColon1 " >:" contained
syntax match AknTerm "^.\+ >: " contains=AknTermColon1
syntax match AknTerm "^.\+ >:$" contains=AknTermColon1

" syntax of links
syntax match AknAnchorBorder "|\|>|\||>" contained
syntax match AknLink "|\w\+>|" contains=AknAnchorBorder
syntax match AknAnchor "|>\w\+|" contains=AknAnchorBorder

" syntax of urls
syntax match AknUrl "\<https\?://\S*"

" include other languages
syntax include @Rust syntax/rust.vim
syntax region AknInclRust matchgroup=AknAnchorBorder start="^>>>rust" end="^<<<$" keepend contains=@Rust


" highlight groups

hi! def link AknHeader1 Title
hi! def link AknHeader2 Special
hi! def link AknHeader3 Constant
hi! def link AknHeader4 Directory
hi! def link AknHeader5 String
hi! def link AknHeader6 Comment
hi! def link AknHeaderBorder Normal
" highlight link AknHeaderBorder ErrorMsg
hi! def link AknLink Directory
hi! def link AknAnchor LineNr
hi! def link AknAnchorBorder LineNr
hi! def link AknUrl Directory
hi! def link AknBashLine ModeMsg
hi! def link AknNoteMark Question
hi! def link AknNoteMark3 Special

if hlexists("DiagnosticError")
  " highliting for nvim (there are more standard hl-groups in nvim than in vim)
  hi! def link AknNoteLine String
  hi! def link AknNote1Line Question
  hi! def link AknNote2Line DiagnosticError
  hi! def link AknArrowNote Comment
  hi! def link AknArrowNote1 DiagnosticError
else
  " highliting for vim
  hi! def link AknNoteLine String
  hi! def link AknNote1Line Question
  hi! def link AknNote2Line ErrorMsg
  hi! def link AknArrowNote Comment
  hi! def link AknArrowNote1 ErrorMsg
endif

hi! def link AknListIndicatorDash Identifier
hi! def link AknListIndicatorStar Identifier
hi! def link AknListIndicatorNumber Identifier
hi! def link AknTerm PreProc
hi! def link AknTermColon Normal
