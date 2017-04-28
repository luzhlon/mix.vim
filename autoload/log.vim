try
py3 << EOF
import logging
logging.basicConfig(
    level    = logging.DEBUG,
    filename = '.vimlog',
    filemode = 'w')
logger = logging.getLogger()
EOF
catch
endt

fun! log#info(...)
    let s = join(a:000)
    py3 logger.info(vim.eval('s'))
endf
fun! log#debug(...)
    let s = join(a:000)
    py3 logger.debug(vim.eval('s'))
endf
fun! log#error(...)
    let s = join(a:000)
    py3 logger.error(vim.eval('s'))
endf
fun! log#warning(...)
    let s = join(a:000)
    py3 logger.warning(vim.eval('s'))
endf
