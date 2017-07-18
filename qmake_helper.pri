# @brief writeKeyValuePair запись пары "ключ-значение" в .qmake.cache
# @param $${1} ключ
# @param $${2} значение
defineTest(writeKeyValuePair) {
    system("echo $${1} = $${2} >> $$OUT_PWD/.qmake.cache")
}

# @brief promotionValue продвижка переменной в файлы исходного кода (*.h, *.c,
# *.cpp) проекта
# @param $${1} продвигаемая переменная
# @param $${2} значение продвигаемой переменной
# @param $${3} режим продвижки. Допустимые значения ifdef, int, str
defineReplace(promotionValue) {
    arg_3 = $${3}

    contains(arg_3, ifdef) {
        promotionValue = $${2} $${1}=$${2}
    }
    contains(arg_3, int) {
        promotionValue = $${1}=$${2}
    }
    contains(arg_3, str) {
        promotionValue = $${1}=\\\"$${2}\\\"
    }

    return ($$promotionValue)
}
