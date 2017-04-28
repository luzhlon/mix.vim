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

fun! qrun#cxx()
    if !exists('s:cxx_comp')
        echo 'No compiler can be found'
        return
    endif
    update
    if !exists('b:binfile')
        let b:binfile = fnamemodify(tempname(), ':r') . '.exe'
    endif
    let g:RunSuccess = printf('TExec %s', b:binfile)
    " The source file is newer than binary
    if getftime(expand('%')) > getftime(b:binfile)
        let cmd = s:cxx_comp(expand('%'), fnameescape(b:binfile))
        exe 'QFRun' cmd
    else
        exe g:RunSuccess
    endif
endf

fun! qrun#dot()
    if !executable('dot')
        echo "Command 'dot' NOT Found"
        return
    endif
    update
    if !exists('b:binfile')
        let b:binfile = fnamemodify(tempname(), ':r') . '.png'
    endif
    let g:RunSuccess = 'sil !' . b:binfile
    if getftime(expand('%')) > getftime(b:binfile)
        exe 'QFRun dot' expand('%') '-Tpng -o' b:binfile
    else
        exe g:RunSuccess
    endif
endf
