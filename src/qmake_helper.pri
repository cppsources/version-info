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
# @param $$3 режим продвижки. Допустимые значения IFDEF, INT, STR
defineReplace(promotion_value) {
    ARG_3 = $$3
    equals(ARG_3, IFDEF) {
        promotion_value = $$2 $$1=$$2
    }
    equals(ARG_3, INT) {
        promotion_value = $$1=$$2
    }
    equals(ARG_3, STR) {
        promotion_value = $$1=\\\"$$2\\\"
    }
    return ($$promotion_value)
}

# @brief recreate_qmake_cache пересоздание .qmake.cache если он уже существует
defineTest(recreate_qmake_cache) {
    QMAKE_CACHE_FILENAME = $$OUT_PWD/.qmake.cache
    exists($$QMAKE_CACHE_FILENAME) {
        unix: system(rm -rf $$QMAKE_CACHE_FILENAME)
        win32: system(DEL /Q /F $$replace(QMAKE_CACHE_FILENAME, /, \\)) # TODO: Протестировать
    }
}
