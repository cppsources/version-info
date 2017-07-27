# @brief is_python_installed проверка, что установлен Python указанной версии
# @param $$1 номер версии
defineTest(is_python_installed) {
    unix: command = python$$1 --version 1>/dev/null 2>/dev/null; echo "$?"
#    win32 { # BUG: Под Windows не работает
#        command = python --version 1>nul 2>nul && echo %errorlevel%
#    }
    return_code = $$system($$command)
    !contains(return_code, 0) { # если return_code не равен 0
        error(error: python $$1 is not installed)
    }
}

version = 2.7
is_python_installed($$version)
