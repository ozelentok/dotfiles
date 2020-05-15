" Vim color file

set background=dark
hi clear
if exists("syntax_on")
    syntax reset
endif
let colors_name="colosus"

" Base color
" ----------
hi Normal           guifg=#ffffff           guibg=#000000
hi Normal           ctermfg=15              ctermbg=16


" Comment Group
" -------------
hi Comment          guifg=#a8a8a8                                   gui=italic
hi Comment          ctermfg=248                                     cterm=none


" Constant Group
" --------------
" any constant
hi Constant         guifg=#87d7d7                                   gui=none
hi Constant         ctermfg=116                                     cterm=none
" strings
hi String           guifg=#ffaf00                                   gui=none
hi String           ctermfg=214                                     cterm=none
" character constant
hi Character        guifg=#ff8700                                   gui=none
hi Character        ctermfg=208                                     cterm=none
" numbers decimal/hex
hi Number           guifg=#afd7ff                                   gui=none
hi Number           ctermfg=153                                     cterm=none
" true, false
hi Boolean          guifg=#d7d787                                   gui=bold
hi Boolean          ctermfg=186                                     cterm=none
" float
hi Float            guifg=#afd7ff                                   gui=none
hi Float            ctermfg=153                                     cterm=none


" Identifier Group
" ----------------
" any variable name
hi Identifier       guifg=#00d7ff                                   gui=bold
hi Identifier       ctermfg=45                                      cterm=none
" function, method, class
hi Function         guifg=#00d7ff                                   gui=bold
hi Function         ctermfg=45                                      cterm=none


" Statement Group
" ---------------
" any statement
hi Statement        guifg=#afd787                                   gui=bold
hi Statement        ctermfg=150                                     cterm=none
" if, then, else
hi Conditional      guifg=#afd75f                                   gui=bold
hi Conditional      ctermfg=149                                     cterm=none
" try, catch, throw, raise
hi Exception        guifg=#afd75f                                   gui=bold
hi Exception        ctermfg=149                                     cterm=none
" for, while, do
hi Repeat           guifg=#afd75f                                   gui=bold
hi Repeat           ctermfg=149                                     cterm=none
" case, default
hi Label            guifg=#afd75f                                   gui=bold
hi Label            ctermfg=149                                     cterm=none
" sizeof, +, *
hi Operator         guifg=#87ffff                                   gui=none
hi Operator         ctermfg=123                                     cterm=none
" any other keyword, e.g. 'sub'
hi Keyword          guifg=#afd75f                                   gui=bold
hi Keyword          ctermfg=149                                     cterm=none


" Preprocessor Group
" ------------------
" generic preprocessor
hi PreProc          guifg=#FFD7AF                                   gui=none
hi PreProc          ctermfg=223                                     cterm=none
" #include
hi Include          guifg=#FFD7AF                                   gui=none
hi Include          ctermfg=223                                     cterm=none
" #define
hi Define           guifg=#FFD7AF                                   gui=none
hi Define           ctermfg=223                                     cterm=none
" same as define
hi Macro            guifg=#FFD7AF                                   gui=none
hi Macro            ctermfg=223                                     cterm=none
" #if, #else, #endif
hi PreCondit        guifg=#FFD7AF                                   gui=none
hi PreCondit        ctermfg=223                                     cterm=none


" Type Group
" ----------
" int, long, char
hi Type             guifg=#87d7ff                                   gui=bold
hi Type             ctermfg=117                                     cterm=none
" static, register, volative
hi StorageClass     guifg=#87d7ff                                   gui=bold
hi StorageClass     ctermfg=117                                     cterm=none
" struct, union, enum
hi Structure        guifg=#87d7ff                                   gui=bold
hi Structure        ctermfg=117                                     cterm=none
" typedef
hi Typedef          guifg=#87d7ff                                   gui=bold
hi Typedef          ctermfg=117                                     cterm=none


" Special Group
" -------------
" any special symbol
hi Special          guifg=#a5a5a5                                   gui=bold
hi Special          ctermfg=181                                     cterm=none
" special character in a constant
hi SpecialChar      guifg=#a5a5a5                                   gui=bold
hi SpecialChar      ctermfg=181                                     cterm=none
" things you can CTRL-]
hi Tag              guifg=#a5a5a5                                   gui=none
hi Tag              ctermfg=181                                     cterm=none
" character that needs attention
hi Delimiter        guifg=#a5a5a5                                   gui=none
hi Delimiter        ctermfg=181                                     cterm=none
" special things inside a comment
hi SpecialComment   guifg=#a5a5a5                                   gui=none
hi SpecialComment   ctermfg=181                                     cterm=none
" debugging statements
hi Debug            guifg=#a5a5a5           guibg=NONE              gui=bold
hi Debug            ctermfg=181             ctermbg=NONE            cterm=none


" Underlined Group
" ----------------
" text that stands out, html links
hi Underlined       guifg=fg                                        gui=underline
hi Underlined       ctermfg=fg                                      cterm=underline


" Ignore Group
" ------------
" left blank, hidden
hi Ignore           guifg=bg
hi Ignore           ctermfg=bg


" Error Group
" -----------
" any erroneous construct
hi Error            guifg=#E85848           guibg=#451E1A           gui=bold
hi Error            ctermfg=15              ctermbg=9               cterm=bold


" Todo Group
" ----------
" todo, fixme, note, xxx
hi Todo             guifg=#FFFF87           guibg=NONE              gui=underline
hi Todo             ctermfg=228             ctermbg=NONE            cterm=underline


" Spelling
" --------
" word not recognized
hi SpellBad                                 guibg=#870000           gui=undercurl
hi SpellBad                                 ctermbg=88              cterm=undercurl
" word not capitalized
hi SpellCap                                 guibg=#0000D7           gui=undercurl
hi SpellCap                                 ctermbg=20              cterm=undercurl
" rare word
hi SpellRare                                guibg=#AF00AF           gui=undercurl
hi SpellRare                                ctermbg=127             cterm=undercurl
" wrong spelling for selected region
hi SpellLocal                               guibg=#ffAF00           gui=undercurl
hi SpellLocal                               ctermbg=214             cterm=undercurl


" Cursor
" ------
" character under the cursor
hi Cursor           guifg=fg                guibg=#0078FF
hi Cursor           ctermfg=bg              ctermbg=153
" like cursor, but used when in IME mode
hi CursorIM         guifg=bg                guibg=#96CDCD
hi CursorIM         ctermfg=bg              ctermbg=116
" cursor column
hi CursorColumn     guifg=NONE              guibg=#202438           gui=none
hi CursorColumn     ctermfg=NONE            ctermbg=236             cterm=none
" cursor line/row
hi CursorLine       guifg=fg                guibg=#202438           gui=none
hi CursorLine       ctermfg=15              ctermbg=236             cterm=none


" Misc
" ----
" directory names and other special names in listings
hi Directory        guifg=#c0e0b0                                   gui=none
hi Directory        ctermfg=151                                     cterm=none
" error messages on the command line
hi ErrorMsg         guifg=#E85848           guibg=#461E1A           gui=none
hi ErrorMsg         ctermfg=196             ctermbg=NONE            cterm=none
" column separating vertically split windows
hi VertSplit        guifg=#777777           guibg=#363946           gui=none
hi VertSplit        ctermfg=242             ctermbg=237             cterm=none
" columns where signs are displayed (used in IDEs)
hi SignColumn       guifg=#9fafaf           guibg=#121212           gui=none
hi SignColumn       ctermfg=145             ctermbg=233             cterm=none
" line numbers
hi LineNr           guifg=#B4D3B1           guibg=#151515
hi LineNr           ctermfg=102             ctermbg=237
" match parenthesis, brackets
hi MatchParen       guifg=#00ff00           guibg=NONE              gui=bold
hi MatchParen       ctermfg=46              ctermbg=NONE            cterm=bold
" the 'more' prompt when output takes more than one line
hi MoreMsg          guifg=#2e8b57                                   gui=none
hi MoreMsg          ctermfg=29                                      cterm=none
" text showing what mode you are in
hi ModeMsg          guifg=fg                guibg=NONE              gui=bold
hi ModeMsg          ctermfg=117             ctermbg=NONE            cterm=none
" the '~' and '@' and showbreak, '>' double wide char doesn't fit on line
hi NonText          guifg=#404040                                   gui=none
hi NonText          ctermfg=235                                     cterm=none
" the hit-enter prompt (show more output) and yes/no questions
hi Question         guifg=fg                                        gui=none
hi Question         ctermfg=fg                                      cterm=none
" meta and special keys used with map, unprintable characters
hi SpecialKey       guifg=#404040
hi SpecialKey       ctermfg=237
" titles for output from :set all, :autocmd, etc
hi Title            guifg=#62bdde                                   gui=none
hi Title            ctermfg=74                                      cterm=none
"hi Title            guifg=#5ec8e5                                   gui=none
" warning messages
hi WarningMsg       guifg=#e5786d                                   gui=none
hi WarningMsg       ctermfg=173                                     cterm=none
" current match in the wildmenu completion
hi WildMenu         guifg=#cae682           guibg=#363946           gui=bold,underline
hi WildMenu         ctermfg=16              ctermbg=186             cterm=bold


" Diff
" ----
" added line
hi DiffAdd          guifg=none              guibg=#004000           gui=none
hi DiffAdd          ctermfg=None            ctermbg=22              cterm=none
" deleted line
hi DiffDelete       guifg=#FF0000           guibg=#202020           gui=none
hi DiffDelete       ctermfg=none            ctermbg=235             cterm=none
" changed line
hi DiffChange       guifg=none              guibg=#282828           gui=none
hi DiffChange       ctermfg=none            ctermbg=237             cterm=none
" changed text within line
hi DiffText         guifg=#FF505F           guibg=#282828           gui=bold
hi DiffText         ctermfg=203             ctermbg=237             cterm=bold


" Folds
" -----
" line used for closed folds
hi Folded           guifg=#91d6f8           guibg=#363946           gui=none
hi Folded           ctermfg=117             ctermbg=238             cterm=none
" column on side used to indicated open and closed folds
hi FoldColumn       guifg=#91d6f8           guibg=#363946           gui=none
hi FoldColumn       ctermfg=117             ctermbg=238             cterm=none


" Search
" ------
" highlight incremental search text; also highlight text replaced with :s///c
hi IncSearch        guifg=#000000           guibg=#55FFFF           gui=none
hi IncSearch        ctermfg=0               ctermbg=14              cterm=none
" hlsearch (last search pattern), also used for quickfix
hi Search                                   guibg=#FFAF00           gui=none
hi Search                                   ctermbg=214             cterm=none


" Popup Menu
" ----------
" normal item in popup
hi Pmenu            guifg=#e0e0e0           guibg=#121212           gui=none
hi Pmenu            ctermfg=253             ctermbg=233             cterm=none
" selected item in popup
hi PmenuSel         guifg=#D7D787           guibg=#3A3A3A           gui=none
hi PmenuSel         ctermfg=186             ctermbg=237             cterm=none
" scrollbar in popup
hi PMenuSbar                                guibg=#5F5F5F           gui=none
hi PMenuSbar                                ctermbg=59              cterm=none
" thumb of the scrollbar in the popup
hi PMenuThumb                               guibg=#878787           gui=none
hi PMenuThumb                               ctermbg=102             cterm=none


" Status Line
" -----------
" status line for current window
hi StatusLine       guifg=#508ED8           guibg=#1C2C3F           gui=bold
hi StatusLine       ctermfg=254             ctermbg=237             cterm=bold
" status line for non-current windows
hi StatusLineNC     guifg=#78777f           guibg=#302F2F           gui=none
hi StatusLineNC     ctermfg=244             ctermbg=237             cterm=none


" Tab Lines
" ---------
" tab pages line, not active tab page label
hi TabLine          guifg=#b6bf98           guibg=#363946           gui=none
hi TabLine          ctermfg=244             ctermbg=236             cterm=none
" tab pages line, where there are no labels
hi TabLineFill      guifg=#cfcfaf           guibg=#363946           gui=none
hi TabLineFill      ctermfg=187             ctermbg=236             cterm=none
" tab pages line, active tab page label
hi TabLineSel       guifg=#efefef           guibg=#414658           gui=bold
hi TabLineSel       ctermfg=254             ctermbg=236             cterm=bold


" Visual
" ------
" visual mode selection
hi Visual           guifg=NONE              guibg=#3050A0
hi Visual           ctermfg=NONE            ctermbg=4
" visual mode selection when vim is not owning the selection (x11 only)
hi VisualNOS        guifg=fg                                        gui=underline
hi VisualNOS        ctermfg=fg                                      cterm=underline

" Line Number
hi LineNr           guifg=#c4a000           guibg=#1c1c1c           gui=bold
hi LineNr           ctermfg=3               ctermbg=234

" NeoMake

hi NeomakeMessageSign        guifg=#87D7FF  guibg=#121212
hi NeomakeMessageSign        ctermfg=117    ctermbg=233

hi NeomakeWarningSign        guifg=#FFFF87  guibg=#121212
hi NeomakeWarningSign        ctermfg=228    ctermbg=233

hi NeomakeErrorSign          guifg=#FF0000  guibg=#121212
hi NeomakeErrorSign          ctermfg=09      ctermbg=233

hi NeomakeInfoSign           guifg=#FFFFFF  guibg=#121212
hi NeomakeInfoSign           ctermfg=15     ctermbg=233

hi NeomakeError              guifg=#FF0000                          gui=undercurl
hi NeomakeError              ctermfg=9                              cterm=underline

hi NeomakeInfo               guifg=#FFFFFF                          gui=undercurl
hi NeomakeInfo               ctermfg=15                             cterm=underline

hi NeomakeMessage            guifg=#87D7FF                          gui=undercurl
hi NeomakeMessage            ctermfg=117                            cterm=underline

hi NeomakeWarning            guifg=#FFFF87                          gui=undercurl
hi NeomakeWarning            ctermfg=228                            cterm=underline
