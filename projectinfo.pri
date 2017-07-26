include(python_helper.pri)
include(qmake_helper.pri)

# @brief get_project_name возвращает имя проекта (имя в верхнем регистре и соответствует макросу)
# @desc в основе имя главного pro-файла проекта, используется в *.pro и *.pri
defineReplace(get_project_name) {
    command = python -c \'import projectinfo; \
    print projectinfo.get_project_name(\"$$_PRO_FILE_\")\'
    projectName = $$system($$command)
    return ($$projectName)
}

# @brief get_project_version возвращает часть версии проекта
# @param $$1 версия проекта, заданная в виде строки:
# $$MAJOR.$$MINOR.$$PATCH.$$BUILD
# @param $$2 часть версии проекта, которую необходимо вернуть. Допустимые
# значения: major, minor, patch, build
# @return в зависимости от $$2, если $$2 не задано или не существует,
# то сообщение об ошибке
defineReplace(get_project_version) {
    # TODO: Eсли $$2 не задано, то сообщение об ошибке

    USE_EXTERNAL_PY_SCRIPT = FALSE

    equals(USE_EXTERNAL_PY_SCRIPT, TRUE) {
        command = python -c \'import projectinfo; \
        print projectinfo.get_project_version(\"$$1\", \"$$2\")\'
    } else {
        line_1  = "\\043!/usr/bin/env python\\n\\n"
        line_2  = "import os\\n\\n"
        line_3  = "def get_project_version(version, param):\\n"
        line_4  = "\\titems = version.split(\".\")\\n"
        line_5  = "\\tif param == \"major\":\\n"
        line_6  = "\\t\\treturn items[0]\\n"
        line_7  = "\\telif param == \"minor\":\\n"
        line_8  = "\\t\\treturn items[1]\\n"
        line_9  = "\\telif param == \"patch\":\\n"
        line_10 = "\\t\\treturn items[2]\\n"
        line_11 = "\\telif param == \"build\":\\n"
        line_12 = "\\t\\treturn items[3]\\n"
        line_13 = "\\telse:\\n"
        line_14 = "\\t\\tassert False\\n\\n"
        line_15 = "print(get_project_version(\"$$1\", \"$$2\"))"

        file_py = $$line_1$$line_2$$line_3$$line_4$$line_5$$line_6$$line_7
        file_py = $$file_py$$line_8$$line_9$$line_10$$line_11$$line_12
        file_py = $$file_py$$line_13$$line_14$$line_15

        command = echo \'$$file_py\' | python
    }
    version = $$system($$command)
    return ($$version)
}

# @brief write_project_version запись версии проекта в .qmake.cache
# @param $$1 версия проекта, заданная в виде строки:
# $$MAJOR.$$MINOR.$$PATCH.$$BUILD
defineTest(write_project_version) {
    write_key_value_pair(project_major_version, $$get_project_version($$1, major))
    write_key_value_pair(project_minor_version, $$get_project_version($$1, minor))
    write_key_value_pair(project_patch_version, $$get_project_version($$1, patch))
    write_key_value_pair(project_build_number_ver, $$get_project_version($$1, build))
}

# @brief get_project_build_info возвращает часть информации о сборке проекта
# @param $$1 информация о сборке проекта, заданная в виде строки:
# $$BUILD_DATETIME.$$BUILD_NUMBER~$$DESC
# @param $$2 часть версии проекта, которую необходимо вернуть. Допустимые
# значения: build_datetime, build_number, build_desc
# @return в зависимости от $$2, если $$2 не задано или не существует,
# то сообщение об ошибке
defineReplace(get_project_build_info) {
    # TODO: $$2 если пусто то error
    command = python -c \'import projectinfo; \
    print projectinfo.get_project_build_info(\"$$1\", \"$$2\")\'
    versionEx = $$system($$command)
    return ($$versionEx)
}

# @brief write_project_build_info запись информации о сборке проекта в .qmake.cache
# @param $$1 информация о сборке проекта, заданная в виде строки:
# $$BUILD_DATETIME.$$BUILD_NUMBER~$$DESC
defineTest(write_project_build_info) {
    write_key_value_pair(project_build_datetime, $$get_project_build_info($$1, build_datetime))
    write_key_value_pair(project_build_number_bi, $$get_project_build_info($$1, build_number))
    write_key_value_pair(project_build_desc, $$get_project_build_info($$1, build_desc))
}

defineTest(write_project_name) {
    write_key_value_pair(project_name, $$get_project_name())
}
