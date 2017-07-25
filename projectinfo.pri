include(python_helper.pri)
include(qmake_helper.pri)

# @brief getProjectName возвращает имя проекта (имя в верхнем регистре и соответствует макросу)
# @desc в основе имя главного pro-файла проекта, используется в *.pro и *.pri
defineReplace(getProjectName) {
    command = python -c \'import projectinfo; \
    print projectinfo.get_project_name(\"$$_PRO_FILE_\")\'
    projectName = $$system($$command)
    return ($$projectName)
}

# @brief getProjectVersion возвращает часть версии проекта
# @param $$1 версия проекта, заданная в виде строки:
# $$MAJOR.$$MINOR.$$PATCH.$$BUILD
# @param $$2 часть версии проекта, которую необходимо вернуть. Допустимые
# значения: major, minor, patch, build
# @return в зависимости от $$2, если $$2 не задано или не существует,
# то сообщение об ошибке
defineReplace(getProjectVersion) {
    # TODO: Eсли $$2 не задано, то сообщение об ошибке

    USE_EXTERNAL_PY_SCRIPT = FALSE

    contains(USE_EXTERNAL_PY_SCRIPT, TRUE) {
        command = python -c \'import projectinfo; \
        print projectinfo.get_project_version(\"$$1\", \"$$2\")\'
    }
    contains(USE_EXTERNAL_PY_SCRIPT, FALSE) {
        line_1 = "echo '\\043!/usr/bin/env python\\n\\n"
        line_2  = "import os\\n\\n"
        line_3  = "def get_project_version(version, param):\\n"
        line_4  = "\\titems = version.split(\".\")\\n"
        line_5  = "\\tif param == \"major\":\\n"
        line_6  = "\\t\\treturn items[0]\\n"
        line_7  = "\\telif param == \"minor\":\\n"
        line_8  = "\\t\\treturn items[1]\\n"
        line_9  = "\\telif param == \"patch\":\\n"
        line_10  = "\\t\\treturn items[2]\\n"
        line_11  = "\\telif param == \"build\":\\n"
        line_12  = "\\t\\treturn items[3]\\n"
        line_13  = "\\telse:\\n"
        line_14  = "\\t\\tassert False\\n\\n"
        line_15 = "print(get_project_version(\"$$1\", \"$$2\"))'"
        file_py = $$line_1$$line_2$$line_3$$line_4$$line_5$$line_6$$line_7
        file_py += $$line_8$$line_9$$line_10$$line_11$$line_12$$line_13
        file_py += $$line_14$$line_15

        command = $$file_py | python
    }

    version = $$system($$command)
    return ($$version)
}

# @brief writeProjectVersion запись версии проекта в .qmake.cache
# @param $$1 версия проекта, заданная в виде строки:
# $$MAJOR.$$MINOR.$$PATCH.$$BUILD
defineTest(writeProjectVersion) {
    writeKeyValuePair(project_major_version, $$getProjectVersion($$1, major))
    writeKeyValuePair(project_minor_version, $$getProjectVersion($$1, minor))
    writeKeyValuePair(project_patch_version, $$getProjectVersion($$1, patch))
    writeKeyValuePair(project_build_number_ver, $$getProjectVersion($$1, build))
}

# @brief getProjectBuildInfo возвращает часть информации о сборке проекта
# @param $$1 информация о сборке проекта, заданная в виде строки:
# $$BUILD_DATETIME.$$BUILD_NUMBER~$$DESC
# @param $$2 часть версии проекта, которую необходимо вернуть. Допустимые
# значения: build_datetime, build_number, build_desc
# @return в зависимости от $$2, если $$2 не задано или не существует,
# то сообщение об ошибке
defineReplace(getProjectBuildInfo) {
    # TODO: $$2 если пусто то error
    command = python -c \'import projectinfo; \
    print projectinfo.get_project_build_info(\"$$1\", \"$$2\")\'
    versionEx = $$system($$command)
    return ($$versionEx)
}

# @brief writeProjectBuildInfo запись информации о сборке проекта в .qmake.cache
# @param $$1 информация о сборке проекта, заданная в виде строки:
# $$BUILD_DATETIME.$$BUILD_NUMBER~$$DESC
defineTest(writeProjectBuildInfo) {
    writeKeyValuePair(project_build_datetime, $$getProjectBuildInfo($$1, build_datetime))
    writeKeyValuePair(project_build_number_bi, $$getProjectBuildInfo($$1, build_number))
    writeKeyValuePair(project_build_desc, $$getProjectBuildInfo($$1, build_desc))
}

defineTest(writeProjectName) {
    writeKeyValuePair(project_name, $$getProjectName())
}
