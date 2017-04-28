" =============================================================================
" Filename:     plugin/ctf.vim
" Author:       luzhlon
" Function:     
" Last Change:  2017/1/30
" =============================================================================

py3 import ctf

fun! s:en_com(a, c, p)
    return filter(['base64', 'url', 'morse'], a:a), {-> v:val =~ a:a})
endf
fun! s:de_com(a, c, p)
    return filter(['rot13', 'base64', 'unicode',
                    \'url', 'morse', 'bacon', 'fence'],
                    \{-> v:val =~ a:a})
endf

fun! s:encode(t)
    try
        call ctf#en#{a:t}()
    endt
endf
fun! s:decode(t)
    try
        call ctf#de#{a:t}()
    endt
endf

com! -complete=customlist,<SID>en_com -nargs=+ Encode call <SID>encode(<f-args>)
com! -complete=customlist,<SID>de_com -nargs=+ Decode call <SID>decode(<f-args>)
