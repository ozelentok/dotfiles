if exists("b:current_syntax")
  finish
endif

syntax case ignore
syntax match gcodeComment ";.*" contains=gcodeTodo
syntax match gcodeGCode "\<[GM]\d\+\>"
syntax match gcodeTool  "\<T\d\+\>"

syntax match gcodeXAxis "\<[XY]-\?\d\+\>"
syntax match gcodeXAxis "\<[XY]-\?\.\d\+\>"
syntax match gcodeXAxis "\<[XY]-\?\d\+\."
syntax match gcodeXAxis "\<[XY]-\?\d\+\.\d\+\>"

syntax match gcodeZAxis "\<Z-\?\d\+\>"
syntax match gcodeZAxis "\<Z-\?\.\d\+\>"
syntax match gcodeZAxis "\<Z-\?\d\+\."
syntax match gcodeZAxis "\<Z-\?\d\+\.\d\+\>"

syntax match gcodeAAxis "\<[ABC]-\?\d\+\>"
syntax match gcodeAAxis "\<[ABC]-\?\.\d\+\>"
syntax match gcodeAAxis "\<[ABC]-\?\d\+\."
syntax match gcodeAAxis "\<[ABC]-\?\d\+\.\d\+\>"

syntax match gcodeEAxis "\<[E]-\?\d\+\>"
syntax match gcodeEAxis "\<[E]-\?\.\d\+\>"
syntax match gcodeEAxis "\<[E]-\?\d\+\."
syntax match gcodeEAxis "\<[E]-\?\d\+\.\d\+\>"

syntax match gcodeIAxis "\<[IJKR]-\?\d\+\>"
syntax match gcodeIAxis "\<[IJKR]-\?\.\d\+\>"
syntax match gcodeIAxis "\<[IJKR]-\?\d\+\."
syntax match gcodeIAxis "\<[IJKR]-\?\d\+\.\d\+\>"

syntax match gcodeFeed "\<F-\?\d\+\>"
syntax match gcodeFeed "\<F-\?\.\d\+\>"
syntax match gcodeFeed "\<F-\?\d\+\."
syntax match gcodeFeed "\<F-\?\d\+\.\d\+\>"

highlight def link gcodeComment Comment
highlight def link gcodeGCode MoreMsg
highlight def link gcodeTool Define

highlight def link gcodeXAxis Constant
highlight def link gcodeZAxis Type
highlight def link gcodeAAxis Macro
highlight def link gcodeEAxis String
highlight def link gcodeIAxis Identifier
highlight def link gcodeSpecials SpecialChar
highlight def link gcodeFeed SpecialChar

let b:current_syntax = "gcode"
