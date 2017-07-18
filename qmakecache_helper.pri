# @brief writeKeyValuePair запись пары "ключ-значение" в .qmake.cache
# @param $${1} ключ
# @param $${2} значение
defineTest(writeKeyValuePair) {
    system("echo $${1} = $${2} >> $$OUT_PWD/.qmake.cache")
}
