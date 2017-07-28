# @brief write_key_value запись ключа и его значения в .qmake.cache
# @param $$1 ключ
# @param $$2 значение
defineTest(write_key_value) {
    system("echo $$1 = $$2 >> $$OUT_PWD/.qmake.cache")
}

# @brief promotion_value продвижка переменной в файлы исходного кода проекта
# @desc файлы исходного кода (*.h, *.c, *.cpp)
# @param $$1 продвигаемая переменная
# @param $$2 значение продвигаемой переменной
# @param $$3 режим продвижки (IFDEF, INT или STR)
defineReplace(promotion_value) {
    ARG_3 = $$3
    equals(ARG_3, IFDEF): return ($$2 $$1=$$2)
    equals(ARG_3, INT): return ($$1=$$2)
    equals(ARG_3, STR): return ($$1=\\\"$$2\\\")

    show_msg(in func \"promotion_value\" arg $$3 not found, ERROR, $$_FILE_)
}

# @brief recreate_qmake_cache пересоздание .qmake.cache если он уже существует
defineTest(recreate_qmake_cache) {
    QMAKE_CACHE_FILENAME = $$OUT_PWD/.qmake.cache
    exists($$QMAKE_CACHE_FILENAME) {
        unix: system(rm -rf $$QMAKE_CACHE_FILENAME)
        # TODO: Протестировать, а также и QMAKE_DEL_FILE
        win32: system(DEL /Q /F $$replace(QMAKE_CACHE_FILENAME, /, \\))
    }
}

# @brief show_msg вывод сообщения указанного типа
# @param $$1 текст сообщения
# @param $$2 тип сообщения (WARNING или ERROR)
# @param $$3 qmake-переменная, содержащая имя файла, из которого вызвана
# функция show_msg
defineTest(show_msg) {
    MSG_MODE = $$2
    CURRENT_FILE = $$3

    equals(MSG_MODE, WARNING): warning($$1 ($$basename(CURRENT_FILE)))
    equals(MSG_MODE, ERROR): error($$1 ($$basename(CURRENT_FILE)))
}
