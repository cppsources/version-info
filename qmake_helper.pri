# @brief write_key_value_pair запись пары "ключ-значение" в .qmake.cache
# @param $$1 ключ
# @param $$2 значение
defineTest(write_key_value_pair) {
    system("echo $$1 = $$2 >> $$OUT_PWD/.qmake.cache")
}

# @brief promotion_value продвижка переменной в файлы исходного кода проекта
# @desc файлы исходного кода (*.h, *.c, *.cpp)
# @param $$1 продвигаемая переменная
# @param $$2 значение продвигаемой переменной
# @param $$3 режим продвижки. Допустимые значения ifdef, int, str
defineReplace(promotion_value) {
    arg_3 = $$3

    contains(arg_3, ifdef) {
        promotion_value = $$2 $$1=$$2
    }
    contains(arg_3, int) {
        promotion_value = $$1=$$2
    }
    contains(arg_3, str) {
        promotion_value = $$1=\\\"$$2\\\"
    }

    return ($$promotion_value)
}

# @brief recreate_qmake_cache пересоздание .qmake.cache если он уже существует
defineTest(recreate_qmake_cache) {
    exists($$OUT_PWD/.qmake.cache) {
        unix: system(rm -rf $$OUT_PWD/.qmake.cache)
        win32 { # TODO: Протестировать
            QMAKE_CACHE_FILENAME = $$OUT_PWD/.qmake.cache
            system(DEL /Q /F $$replace(QMAKE_CACHE_FILENAME, /, \\))
        }
    }
}
