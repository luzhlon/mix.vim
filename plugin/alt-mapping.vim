" =============================================================================
" Filename:     plugin/alt-mapping.vim
" Author:       luzhlon
" Function:     Set alt-key mapping on terminal
" Last Change:  2017/1/14
" =============================================================================

if has('gui_running') || has('nvim')
    finish
endif

set ttimeout
if &ttimeoutlen == -1
  set ttimeoutlen=50
endif

function! s:printable_characters()
  " leaving out problematic characters: 'O', double quote, pipe and '['
  let ascii_nums = [33] + range(35, 61) + range(63, 78) + range(80, 90) + range(92, 123) + [125, 126]
  return map(ascii_nums, 'nr2char(v:val)')
endfunction

function! s:enable_alt_map(char)
  exe "set <M-".a:char.">=\<Esc>".a:char
endfunction

function! s:enable_alt_map_for_special_chars()
  " double quote
  exe 'set <M-\">=\"'
  " pipe
  exe 'set <M-bar>=\|'
  " space - messes all other mappings
  " exe "set <M-space>= "
  " Can't get this one to work
  " exe "set <M-\>>=\>"
  " left bracket just messes vim up
  " exe 'set <M-[>=['
endfunction

for char in s:printable_characters()
    call s:enable_alt_map(char)
endfor
call s:enable_alt_map_for_special_chars()
