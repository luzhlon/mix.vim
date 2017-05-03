
com! -nargs=1 -complete=shellcmd QExec call qrun#exec(<q-args>)
com! -nargs=* -complete=file QStdin call qrun#stdin(<q-args>)
com! -nargs=* -complete=shellcmd QFRun call qrun#qfrun(<q-args>)
