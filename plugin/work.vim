" =============================================================================
" Filename:     plugin/work.vim
" Author:       luzhlon
" Function:     workspace
" Last Change:  2017/4/08
" =============================================================================

" Check default settings
let Work = exists('Work') ? Work : {}
" Default various to save
let Work.default = get(Work, 'default', {
    \ 'global': [],
    \ 'option': ['lines', 'columns', 'title', 'titlestring', 'ft']
    \ })
" Workspace file
let Work.file = get(Work, 'file', '.work.json')
" Workspace dir
let Work.dir = get(Work, 'dir', '.workspace')
" Enable / Disable
let Work.enable = 0

fun! s:OnLeave()
    if !g:Work.enable|return|endif
    call work#save()
endf
fun! s:OnEnter()
    let file = argv(0)
    if fnamemodify(file, ':t') == g:Work.file
        exe 'bd' file
        call work#load(file)
    endif
endf
au VimEnter    * call <SID>OnEnter()
au VimLeavePre * call <SID>OnLeave()

com! WorkCreate call work#create()
com! WorkDelete call work#delete()
