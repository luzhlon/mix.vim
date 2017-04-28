fun! ctf#en#unicode()
endf
fun! ctf#en#morse()
    let _ = lib#getbuf()
    py3 _ = ctf.en.morse(vim.eval('_'))
    call lib#setbuf(py3eval('_'))
endf
fun! ctf#en#url()
    let _ = lib#getbuf()
    py3 _ = ctf.en.url(vim.eval('_'))
    call lib#setbuf(py3eval('_'))
endf
fun! ctf#en#base64()
    let _ = lib#getbuf()
    py3 _ = ctf.en.base64(vim.eval('_'))
    call lib#setbuf(py3eval('_'))
endf
