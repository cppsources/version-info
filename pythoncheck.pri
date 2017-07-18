## /// проверка того, что установлен Python версии 2.7
version = 2.7
unix: command = python$$version --version 1>/dev/null 2>/dev/null; echo "$?"
# BUG: Под Windows не работает, а также создается файл nul в src (под Linux)
#win: command = python --version 1>nul 2>nul && echo 0
return_code = $$system($$command)
!contains(return_code, 0) { # если return_code не равен 0
    error(error: python $$version is not installed)
}
