" =============================================================================
" Filename:     autoload/util.vim
" Author:       luzhlon
" Function:     Some useful scripts
" Last Change:  2017/1/29
" =============================================================================

" Next buffer with &bt=='', cmd = bn!|bp!
fun! util#SwitchFile(cmd)
    let nr = bufnr('%')
    exe a:cmd
    while bufnr('%') != nr && &buftype != ''
        exe a:cmd
    endw
endf
" Switch from .h and .cxx files
let s:cxx_ext = ['c', 'cpp', 'cc']
let s:ch_ext = ['h', 'hpp']
fun! util#ToggleHeader()
    let ex = expand('%:e')
    let r =  expand('%:r')
    if index(s:cxx_ext, ex) < 0
        for e in s:cxx_ext
            let f = r . '.' . e
            if filereadable(f)
                exe (bufnr(f) < 0 ? 'e!' : 'b!') f
                return
            endif
        endfo
        echo 'no cxx file'
    else
        for e in  s:ch_ext
            let f = r . '.' . e
            if filereadable(f)
                exe (bufnr(f) < 0 ? 'e!' : 'b!') f
                return
            endif
        endfo
        echo 'no header file'
    endif
endf
let s:comment = {'lua' : '--', 'python' : '#', 'vim' : '"',
            \    'c' : '//', 'cpp' : '//',   'java' : '//', 'javascript' : '//'}
" Toggle comment
fun! util#ToggleComment(...) range
    if a:0 > 1
        let i = a:1 | let j = a:2
    else
        let i = a:firstline | let j = a:lastline
    endif
try
    while i <= j
        let line = getline(i)
        let comchar = s:comment[&ft]
        if match(line, '^' . comchar) >= 0
            call setline(i, substitute(line, '^'.comchar, '', ''))
        else
            call setline(i, comchar . line)
        endif
        let i += 1
    endw
endtry
endf
" Quit buffer but not with the window close
fun! util#QuitBuffer()
    if &bt=='nofile' && 2 == confirm('Not a file, continue quit?', "&Yes\n&No", 2, "Warning")
        return
    endif
    let curbuf = bufnr('%')
    let a = bufnr('#')
    if bufexists(a) && getbufvar(a, '&bt') == ''
        b!#
    else
        bnext
    endif
    exe 'confirm' 'bw' curbuf
endf
