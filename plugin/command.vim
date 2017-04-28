" =============================================================================
" Filename:     plugin/command.vim
" Author:       luzhlon
" Function:     My vim commands
" Last Change:  2017/1/31
" =============================================================================

com! -nargs=* -complete=shellcmd QFRun call job#util#qfrun(<f-args>)
com! -nargs=1 -complete=shellcmd Exec call util#Exec(join([<f-args>]))
com! -nargs=1 -complete=shellcmd TExec call util#ExeInTerm(join([<f-args>]))

"change current directory
com! Locate if &buftype == ''|lc %:p:h |endif
"open a scratch buffer
com! Scratch ene!|setl bt=nofile bh=wipe
com! -nargs=1 YouDao  call netrw#BrowseX('http://dict.youdao.com/w/eng/'. <f-args>, 0)
com! -nargs=1 Baidu call netrw#BrowseX('https://www.baidu.com/s?wd=' . <f-args>, 0) 

com! CountChar echo wordcount()

if has('gui_running')
    "enlarge/reduce font size
    com! FontEnlarge call <SID>addFontSize(1)
    com! FontReduce  call <SID>addFontSize(-1)
    fun! s:addFontSize(n)
        let &gfn =
            \substitute(&gfn, '\d\+', '\=submatch(0)+' . a:n, '')
        let &gfw =
            \substitute(&gfw, '\d\+', '\=submatch(0)+' . a:n, '')
    endf
endif

if has('win32')
    com! Ps exe 'Scratch' | r! tasklist
    com! EditHosts e ++ff=dos C:\Windows\System32\drivers\etc\hosts
else
    com! Ps exe 'Scratch' | r! ps aux
    com! EditHosts e /etc/hosts
endif
