win32 { # HACK
    CURRENT_FILE = $$_FILE_
    CURRENT_FILE_NAME = $$basename(CURRENT_FILE)
    error(ERROR: platform windows not supported in $$CURRENT_FILE_NAME)
}

# @brief is_python_installed проверка, что установлен Python указанной версии
# @param $$1 номер версии
defineTest(is_python_installed) {
    unix: command = python$$1 --version 1>/dev/null 2>/dev/null; echo "$?"
    # BUG: Под Windows не работает, а под Linux создает файл nul
#    win32: command = python --version 1>nul 2>nul && echo %errorlevel%
    return_code = $$system($$command)
    !equals(return_code, 0) {
        error(error: python $$1 is not installed)
    }
}

version = 2.7
is_python_installed($$version)
