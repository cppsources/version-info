include(qmake_helper.pri)

win32: show_msg(platform windows not supported, ERROR, $$_FILE_) # HACK

# @brief is_python_installed проверка, что установлен Python указанной версии
# @param $$1 номер версии
defineTest(is_python_installed) {
    unix: command = python$$1 -V 1>/dev/null 2>/dev/null; echo "$?"
    # BUG: Под Windows не работает, а под Linux создает файл nul
#    win32: command = python --version 1>nul 2>nul && echo %errorlevel%
    return_code = $$system($$command)
    !equals(return_code, 0) {
        show_msg(python $$1 is not installed, ERROR)
    }
}

version = 2.7
is_python_installed($$version)
