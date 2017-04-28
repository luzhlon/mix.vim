" If workspace directory is not exists, create it
fun! s:checkwdir()
    if !isdirectory(g:Work.dir)
        call mkdir(g:Work.dir, 'p')
    endif
endf
" Create workspace
fun! work#create()
    call writefile([json_encode(g:Work.default)], g:Work.file)
    call s:checkwdir()
    let g:Work.enable = 1
endf
" Delete workspace
fun! work#delete()
    let g:Work.enable = 0
endf
" Save windows and files
fun! s:savefiles()
    set sessionoptions=blank,help,tabpages,winpos,unix,buffers
    exe 'mks!' work#fname('session.vim')
endf
fun! s:loadfiles()
    let file = work#fname('session.vim')
    if filereadable(file)
        exe 'so' file
    endif
endf
" Save variables
fun! s:savevars()
    let global = {}
    let option = {}
    for i in g:Work.default.global
        if has_key(g:, i)
            let global[i] = g:[i]
        endif
    endfo
    for i in g:Work.default.option
        let option[i] = eval('&' . i)
    endfo
    " Save variables and options
    let vars = { 'global': global, 'option': option }
    call work#write('vars.json', vars)
endf
fun! s:loadvars()
    let vars = work#read('vars.json')
    if empty(vars)|return|endif
    call extend(g:, vars.global)
    for [k, v] in items(vars.option)
        exe 'let &'.k '= v'
    endfor
endf
fun! work#fname(f)
    return g:Work.dir . '/' . a:f
endf 
fun! work#write(file, data)
    let file = work#fname(a:file)
    return writefile([json_encode(a:data)], file)
endf
fun! work#read(file)
    let file = work#fname(a:file)
    if !filereadable(file)|return 0|endif
    return json_decode(join(readfile(file)))
endf
" Save workspace
fun! work#save()
    call s:checkwdir()
    do User BeforeWorkSave
    call s:savevars()
    call s:savefiles()
endf
" Load workspace
fun! work#load(f)
    if !filereadable(a:f)|return|endif
    let file = a:f
    let g:Work.file    = file
    let g:Work.dir     = fnamemodify(file, ':p:h') . '/' . g:Work.dir
    let g:Work.default = json_decode(join(readfile(file)))
    let g:Work.enable  = 1
    call s:checkwdir()
    call s:loadfiles()
    call s:loadvars()
    do User AfterWorkLoad
endf
