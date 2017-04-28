" =============================================================================
" Filename:     plugin/work/viewext.vim
" Author:       luzhlon
" Function:     Save/Load gui windows state and NERDTree
" Last Change:  2017/4/08
" =============================================================================
fun! s:OnSave()
    let w = s:NERDClose()
    if w
        let g:NERDTreeWinSize = w
    endif
    let exts = {
        \ 'MAX': has('gui_running')?(getwinposx()<0&&getwinposy()<0):0,
        \ 'NERD': w
    \ }
    call work#write('viewext.json', exts)
endf
fun! s:OnLoad()
    let exts = work#read('viewext.json')
    if exts.MAX && has('gui_running')
        simalt ~x
    endif
    if exts.NERD
        NERDTree
        winc p
    endif
endf

au User BeforeWorkSave call <SID>OnSave()
au User AfterWorkLoad  call <SID>OnLoad()
" 关闭NERDTree，存在NERDTree窗口返回其宽度
fun! s:NERDClose()
    let i = 0
    while 1
        let b = winbufnr(i)
        if b < 0 | break | endif
        if bufname(b) =~ '^NERD_tree_\d\+'
            let id = win_getid(i)
            call win_gotoid(id)
            if &bt != 'nofile' | continue | endif
            let wi = getwininfo(id)
            winc c | winc p
            return wi[0].width
        endif
        let i += 1
    endw
    return 0
endf
