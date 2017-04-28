" =============================================================================
" Filename:     lib.vim
" Author:       luzhlon
" Description:  some useful function of vim script
" Last Change:  2017/2/17
" =============================================================================

" Echo text with hilight
fun! lib#echohn(h, ...)
    exe 'echoh' a:h
    echon join(a:)
endf
" Get selected text
fun! lib#getselect()
    let [lnum1, col1] = getpos("'<")[1:2]
    let [lnum2, col2] = getpos("'>")[1:2]
    let lines = getline(lnum1, lnum2)
    let lines[-1] = lines[-1][: col2 - (&sel == 'inclusive' ? 1 : 2)]
    let lines[0] = lines[0][col1 - 1:]
    return join(lines, "\n")
endf
" Get content of current buffer
fun! lib#getbuf()
    norm! gg0VG$"-y
    return @-
endf
" Set content of current buffer
fun! lib#setbuf(dat)
    let @- = a:dat
    norm! ggVG"-p
endf
" Save options to a dictonary
fun! lib#storeopt(...)
    if !a:0| return {}| endif
    let opt = {}
    for k in a:000
        let opt[k] = eval('&g:'.k)
    endfor
    return opt
endf
" Restore options from a dictonary
fun! lib#restoreopt(opt)
    for k in keys(a:opt)
        let _ = a:opt[k]
        exe 'let &g:'.k '= _'
    endfor
endf
" Get string on cursor both sides
fun! lib#curstr(...)
    let c = col('.')
    let n = c - 1
    let l = getline('.')
    let f = strpart(l, 0, n)
    return a:0 ? [f, strpart(l, n)] : f
endf

" =======================================================
let s:deep = 0
fun! s:echopre(...)
    echon repeat('  ', s:deep)
    if a:0|echon join(a:000)|endif
endf
" Format output
fun! lib#putlist(d)
    let _t = type(a:d)
    if _t == v:t_dict
        echon "{\n"     |let s:deep += 1
        for i in keys(a:d)
            let v = a:d[i]
            call s:echopre(i, ":\t")
            call lib#putlist(v)|echon ",\n"
        endfo
        let s:deep -= 1 |call s:echopre()|echon "}"
    elseif _t == v:t_list
        echon "[\n"     |let s:deep += 1
        for i in a:d
            call s:echopre()
            call lib#putlist(i)|echon ",\n"
        endfo
        let s:deep -= 1 |call s:echopre()|echon "]"
    else    |echon a:d  |endif
endf
