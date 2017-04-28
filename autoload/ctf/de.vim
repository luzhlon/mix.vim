fun! ctf#de#rot13()
    let _ = lib#getbuf()
    py3 _ = ctf.de.rot13(vim.eval('_'))
    call lib#setbuf(py3eval('_'))
endf

fun! ctf#de#unicode()
    s/u\(\x\+\)/\=nr2char('0x'.submatch(1)+0)/g
endf

fun! ctf#de#morse()
    let _ = lib#getbuf()
    py3 _ = ctf.de.morse(vim.eval('_'))
    call lib#setbuf(py3eval('_'))
endf

fun! ctf#de#url()
    let _ = lib#getbuf()
    py3 _ = ctf.de.url(vim.eval('_'))
    call lib#setbuf(py3eval('_'))
endf

fun! ctf#de#base64()
    let _ = lib#getbuf()
    py3 _ = ctf.de.base64(vim.eval('_'))
    call lib#setbuf(py3eval('_'))
endf

fun! ctf#de#bacon()
    let _ = lib#getbuf()
    py3 _ = ctf.de.bacon(vim.eval('_'))
    call lib#setbuf(py3eval('_'))
endf

fun! ctf#de#fence()
    let _ = lib#getbuf()
    py3 _ = ctf.de.fence(vim.eval('_'))
    call lib#setbuf(py3eval('_'))
endf
