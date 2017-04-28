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
fun! job#util#qfrun(...)
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
