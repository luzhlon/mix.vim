" =============================================================================
" Filename:     plugin/pylibs.vim
" Author:       luzhlon
" Function:     Load vim script needed python libs
" Last Change:  2017/3/8
" =============================================================================

if !has('python3')|finish|endif

let _ = simplify(expand('<sfile>:p:h') . '/../pylibs')
py3 import sys; sys.path.append(vim.eval('_'))

for f in glob(_ . '/*.vim',0,1)
    try | exe 'so' f | catch | endt
endfo
