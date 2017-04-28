fun! job#cb#init()
    if !exists('s:init')
        let s:init = 1
    endif
endf
fun! job#cb#add2qf(job, d)
    cadde a:d
endf
fun! job#cb#add2qfb(job, d)
    cadde a:d
    cbottom
endf
