# @brief isPythonInstalled проверка того, что установлен Python требуемой версии
# @param $$1 версия python
defineTest(isPythonInstalled) {
    unix: command = python$$1 --version 1>/dev/null 2>/dev/null; echo "$?"
    # BUG: Под Windows не работает, а также создается файл nul в src (под Linux)
    #win: command = python --version 1>nul 2>nul && echo 0
    return_code = $$system($$command)
    !contains(return_code, 0) { # если return_code не равен 0
        error(error: python $$1 is not installed)
    }
}

version = 2.7
isPythonInstalled($$version)
