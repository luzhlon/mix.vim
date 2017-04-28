" =============================================================================
" Filename:     plugin/util.vim
" Author:       luzhlon
" Function:     Some useful scripts
" Last Change:  2017/1/29
" =============================================================================

com! NextFile      call util#SwitchFile('bn!')
com! PrevFile      call util#SwitchFile('bp!')
com! ToggleHeader  call util#ToggleHeader()
com! QuitBuffer    call util#QuitBuffer()
