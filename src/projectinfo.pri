include(python_helper.pri)
include(qmake_helper.pri)

win32: show_msg(platform windows not supported, ERROR, $$_FILE_) # HACK

# @brief get_project_name возвращает имя проекта в формате макроса,
# т. е. в верхнем регистре и "-" (если есть) заменено на "_"
# @param $$1 имя главного pro-файла проекта
defineReplace(get_project_name) {
    USE_PROJECTINFO_PY = FALSE

    equals(USE_PROJECTINFO_PY, TRUE) {
        command = python -c \'import projectinfo; \
        print projectinfo.get_project_name(\"$$_PRO_FILE_\")\'
    } else {
        line_1  = "\\043!/usr/bin/env python\\n\\n"
        line_2  = "import os\\n\\n"
        line_3  = "def get_project_name(pro_file_name):\\n"
        line_4  = "\\tbasename = os.path.basename(pro_file_name)\\n"
        line_5  = "\\tproject_name = os.path.splitext(basename)[0]\\n"
        line_6  = "\\tproject_name = project_name.upper()\\n"
        line_7  = "\\tproject_name = project_name.replace(\"-\", \"_\")\\n"
        line_8  = "\\treturn project_name\\n\\n"
        line_9  = "print(get_project_name(\"$$1\"))"

        file_py = $$line_1$$line_2$$line_3$$line_4$$line_5$$line_6$$line_7
        file_py = $$file_py$$line_8$$line_9

        command = echo \'$$file_py\' | python
    }
    project_name = $$system($$command)
    return ($$project_name)
}

# @brief get_project_version возвращает часть версии проекта
# @param $$1 версия проекта, в формате: $$MAJOR.$$MINOR.$$PATCH.$$BUILD
# @param $$2 часть версии проекта, которую необходимо вернуть. Допустимые
# значения: major, minor, patch, build
# @return в зависимости от $$2, если $$2 не задано или не существует,
# то сообщение об ошибке
defineReplace(get_project_version) {
    # TODO: Eсли $$2 не задано, то сообщение об ошибке

    USE_PROJECTINFO_PY = FALSE

    equals(USE_PROJECTINFO_PY, TRUE) {
        command = python -c \'import projectinfo; \
        print projectinfo.get_project_version(\"$$1\", \"$$2\")\'
    } else {
        line_1  = "\\043!/usr/bin/env python\\n\\n"
        line_2  = "def get_project_version(version, param):\\n"
        line_3  = "\\titems = version.split(\".\")\\n"
        line_4  = "\\tif param == \"major\":\\n"
        line_5  = "\\t\\treturn items[0]\\n"
        line_6  = "\\telif param == \"minor\":\\n"
        line_7  = "\\t\\treturn items[1]\\n"
        line_8  = "\\telif param == \"patch\":\\n"
        line_9  = "\\t\\treturn items[2]\\n"
        line_10 = "\\telif param == \"build\":\\n"
        line_11 = "\\t\\treturn items[3]\\n"
        line_12 = "\\telse:\\n"
        line_13 = "\\t\\tassert False\\n\\n"
        line_14 = "print(get_project_version(\"$$1\", \"$$2\"))"

        file_py = $$line_1$$line_2$$line_3$$line_4$$line_5$$line_6
        file_py = $$file_py$$line_7$$line_8$$line_9$$line_10$$line_11
        file_py = $$file_py$$line_12$$line_13$$line_14

        command = echo \'$$file_py\' | python
    }
    version = $$system($$command)
    return ($$version)
}

# @brief get_project_build_info возвращает часть информации о сборке проекта
# @param $$1 информация о сборке проекта, в формате:
# $$BUILD_DATETIME.$$BUILD_NUMBER~$$DESC
# @param $$2 часть версии проекта, которую необходимо вернуть. Допустимые
# значения: build_datetime, build_number, build_desc
# @return в зависимости от $$2, если $$2 не задано или не существует,
# то сообщение об ошибке
defineReplace(get_project_build_info) {
    # TODO: $$2 если пусто то error

    USE_PROJECTINFO_PY = FALSE

    equals(USE_PROJECTINFO_PY, TRUE) {
        command = python -c \'import projectinfo; \
        print projectinfo.get_project_build_info(\"$$1\", \"$$2\")\'
    } else {
        line_1 = "\\043!/usr/bin/env python\\n\\n"
        line_2 = "def get_project_build_info(build_info, param):\\n"
        line_3 = "\\tif param == \"build_datetime\":\\n"
        line_4 = "\\t\\treturn build_info.split(\".\")[0]\\n"
        line_5 = "\\telif param == \"build_number\":\\n"
        line_6 = "\\t\\treturn build_info.split(\".\")[1].split(\"~\")[0]\\n"
        line_7 = "\\telif param == \"build_desc\":\\n"
        line_8 = "\\t\\treturn build_info.split(\".\")[1].split(\"~\")[1]\\n\\n"
        line_9 = "print(get_project_build_info(\"$$1\", \"$$2\"))"

        file_py = $$line_1$$line_2$$line_3$$line_4$$line_5$$line_6$$line_7
        file_py = $$file_py$$line_8$$line_9

        command = echo \'$$file_py\' | python
    }
    project_build_info = $$system($$command)
    return ($$project_build_info)
}

# @brief write_project_info запись информации о проекте в .qmake.cache
# @param $$1 имя главного pro-файла проекта
# @param $$2 версия проекта, в формате: $$MAJOR.$$MINOR.$$PATCH.$$BUILD
# @param $$3 информация о сборке проекта, в формате:
# $$BUILD_DATETIME.$$BUILD_NUMBER~$$DESC
defineTest(write_project_info) {
    ARG_1 = $$1
    ARG_2 = $$2
    ARG_3 = $$3

    !isEmpty(ARG_1) {
        write_key_value(PROJECT_NAME, $$get_project_name($$ARG_1))
    }

    !isEmpty(ARG_2) {
        write_key_value(PROJECT_MAJOR_VERSION, $$get_project_version($$ARG_2, major))
        write_key_value(PROJECT_MINOR_VERSION, $$get_project_version($$ARG_2, minor))
        write_key_value(PROJECT_PATCH_VERSION, $$get_project_version($$ARG_2, patch))
        write_key_value(PROJECT_BUILD_NUMBER_VER, $$get_project_version($$ARG_2, build))
    }

    !isEmpty(ARG_3) {
        write_key_value(PROJECT_BUILD_DATETIME, $$get_project_build_info($$ARG_3, build_datetime))
        write_key_value(PROJECT_BUILD_NUMBER_BI, $$get_project_build_info($$ARG_3, build_number))
        write_key_value(PROJECT_BUILD_DESC, $$get_project_build_info($$ARG_3, build_desc))
    }
}
