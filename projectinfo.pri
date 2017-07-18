include(pythoncheck.pri)
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
# $$MAJOR.$$MINOR.$$(PATCH.$$BUILD
# @param $$2 часть версии проекта, которую необходимо вернуть. Допустимые
# значения: major, minor, patch, build
# @return в зависимости от $$2, если $$2 не задано или не существует,
# то сообщение об ошибке
defineReplace(getProjectVersion) {
    # TODO: Eсли $$2 не задано, то сообщение об ошибке
    command = python -c \'import projectinfo; \
    print projectinfo.get_project_version(\"$$1\", \"$$2\")\'
    version = $$system($$command)
    return ($$version)
}

# @brief writeProjectVersion запись версии проекта в .qmake.cache
# @param $$1 версия проекта, заданная в виде строки:
# $$MAJOR.$$MINOR.$$(PATCH.$$BUILD
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
