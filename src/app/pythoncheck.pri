## /// проверка того, что установлен Python версии 2.7
version = 2.7
unix: command = python$${version} --version 1>/dev/null 2>/dev/null; echo "$?"
# BUG: создается файл nul в src (под Linux)
#win: command = python --version 1>nul 2>nul && echo 0 # FIXME: not working!
return_code = $${system($${command})}
!contains(return_code, 0) { # если return_code не равен 0
    error(python $${version} is not installed)
}
