" =============================================================================
" Filename:     autoload/qrun.vim
" Author:       luzhlon
" Function:     Run a file quickly
" Last Change:  2017/4/23
" =============================================================================

" Check compiler
if has('win32') && executable('cl')
    let s:cxx_comp = {s, o->printf('cmd /c cl %s /Fo"%s" /Fe"%s"',
                \ s, fnamemodify(o, ':p:r') . '.obj', o)}
elseif executable('g++')
    let s:cxx_comp = {s, o->printf('g++ -std=c++11 %s -o %s', s, o)}
elseif executable('clang++')
    let s:cxx_comp = {s, o->printf('clang++ -std=c++11 %s -o %s', s, o)}
endif

let s:stdin  = ''
" Set or show the stdin file
fun! qrun#stdin(...)
    if a:0
        let s:stdin = a:1
    else
        echo s:stdin
    endif
endf
" Execute a command
fun! s:execmd(cmd)
    exe (has('win32') ? '!start': '!') fnamemodify(a:cmd, ':p:S')
endf
" Execute a command
fun! qrun#exec(cmd)
    for i in range(1, winnr('$'))
        let bt = getbufvar(winbufnr(i), '&bt')
        if bt == 'terminal'
            exe i 'winc w'
            call feedkeys("i\<c-u>")
            call feedkeys(a:cmd)
            call feedkeys("\<cr>")
            return
        endif
    endfo
    return s:execmd(a:cmd)
endf
fun! s:onexit(job, code)
    let f = 'copen|winc p'|let s = f
    if exists('g:RunFailure')
        let f = g:RunFailure|unlet g:RunFailure
    endif
    if exists('g:RunSuccess')
        let s = g:RunSuccess|unlet g:RunSuccess
    endif
    exe a:code ? f: s
endf
" Run a job and put it's output to quickfix
fun! qrun#qfrun(...)
    if !a:0 | return | endif
    if exists('s:pid')&&job#running(s:pid)
        echom 'A task is running'
    return|endif
    cexpr ''
    let cmd = join(a:000)
    let s:pid = job#start(cmd, { 'onout' : 'job#cb#add2qfb',
                                \'onerr' : 'job#cb#add2qfb',
                                \'onexit': funcref('s:onexit')})
endf

fun! qrun#cxx()
    if !exists('s:cxx_comp')
        echo 'No compiler can be found'
        return
    endif
    update
    if !exists('b:binfile')
        let b:binfile = fnamemodify(tempname(), ':r') . '.exe'
    endif
    let g:RunSuccess = [printf('QExec %s', b:binfile)]
    if !empty(s:stdin)
        call add(g:RunSuccess, '< ' . s:stdin)
    endif
    let g:RunSuccess = join(g:RunSuccess)
    " The source file is newer than binary
    if getftime(expand('%')) > getftime(b:binfile)
        let cmd = s:cxx_comp(expand('%'), fnameescape(b:binfile))
        exe 'QFRun' cmd
    else
        exe g:RunSuccess
    endif
endf

