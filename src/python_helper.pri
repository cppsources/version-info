include(qmake_helper.pri)

win32: error(platform windows not supported ($$basename(_FILE_))) # HACK

# @brief get_python_version возвращает версию установленного Python
# @return если Python установлен, то версия в формате MAJOR.MINOR.PATCH, иначе
# пустая строка
defineReplace(get_python_version) {
    !is_app_installed(python): return ()
    unix: COMMAND = echo `python -V 2>&1 | grep -Po \'(?<=Python )(.+)\'`
    RESULT = $$system($$COMMAND)
    return ($$RESULT)
}

# @brief is_python_supported_version_installed определяет, соответствует ли
# версии установленного Python, одной из указанных версий
# @param PY_VERS список версий Python, разделенных запятыми или пробелами
# @return true - соответствует, иначе false
defineTest(is_python_supported_version_installed) {
    PY_VERS = $$ARGS
    count(PY_VERS, 0): error(qmake: too few or to many arguments in the \
        function \'is_python_supported_version_installed(version)\')

    PY_VER = $$get_python_version()
    contains(PY_VERS, $$PY_VER): return (true)
    return (false)
}
