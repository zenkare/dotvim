set background=dark
hi clear
if exists('syntax on') | syntax reset | endif
let g:colors_name='darkness'

hi! ColorColumn     cterm=NONE            ctermfg=NONE  ctermbg=233
hi! Comment         cterm=bold            ctermfg=0     ctermbg=0
hi! CursorColumn    cterm=NONE            ctermfg=NONE  ctermbg=234
hi! CursorLine      cterm=NONE            ctermfg=NONE  ctermbg=234
hi! CursorLineNr    cterm=NONE            ctermfg=7     ctermbg=0
hi! DiffAdd         cterm=NONE            ctermfg=2     ctermbg=NONE
hi! DiffChange      cterm=NONE            ctermfg=15    ctermbg=NONE
hi! DiffDelete      cterm=NONE            ctermfg=9     ctermbg=NONE
hi! DiffText        cterm=NONE            ctermfg=6     ctermbg=NONE
hi! FoldColumn      cterm=NONE            ctermfg=15    ctermbg=NONE
hi! Folded          cterm=NONE            ctermfg=7     ctermbg=0
hi! IncSearch       cterm=NONE            ctermfg=240   ctermbg=11
hi! LineNr          cterm=NONE            ctermfg=7     ctermbg=0
hi! MatchParen      cterm=NONE            ctermfg=249   ctermbg=240
hi! MoreMsg         cterm=NONE            ctermfg=240   ctermbg=NONE
hi! NonText         cterm=NONE            ctermfg=240   ctermbg=NONE
hi! Normal          cterm=bold            ctermfg=7     ctermbg=0
hi! Pmenu           cterm=NONE            ctermfg=7     ctermbg=0
hi! PmenuSel        cterm=NONE            ctermfg=15    ctermbg=0
hi! Question        cterm=NONE            ctermfg=9     ctermbg=NONE
hi! QuickFixLine    cterm=NONE            ctermfg=NONE  ctermbg=NONE
hi! Search          cterm=NONE            ctermfg=NONE  ctermbg=NONE
hi! SignColumn      cterm=NONE            ctermfg=NONE  ctermbg=16
hi! StatusLine      cterm=NONE            ctermfg=245   ctermbg=233
hi! StatusLineNC    cterm=NONE            ctermfg=240   ctermbg=234
hi! StatusLineTerm  cterm=NONE            ctermfg=0     ctermbg=121
hi! TabLine         cterm=NONE            ctermfg=240   ctermbg=234
hi! TabLineFill     cterm=NONE            ctermfg=249   ctermbg=234
hi! TabLineSel      cterm=NONE            ctermfg=249   ctermbg=233
hi! Title           cterm=NONE            ctermfg=NONE  ctermbg=NONE
hi! Todo            cterm=NONE            ctermfg=15    ctermbg=0
hi! Underlined      cterm=NONE            ctermfg=249   ctermbg=NONE
hi! VertSplit       cterm=NONE            ctermfg=234   ctermbg=234
hi! Visual          cterm=NONE            ctermfg=0     ctermbg=15
hi! WarningMsg      cterm=NONE            ctermfg=16    ctermbg=11
hi! WildMenu        cterm=NONE            ctermfg=249   ctermbg=236

hi! link Constant   Normal
hi! link Identifier Normal
hi! link Statement  Normal
hi! link PreProc    Normal
hi! link Type       Normal
hi! link Special    Normal
hi! link ModeMsg    MoreMsg
