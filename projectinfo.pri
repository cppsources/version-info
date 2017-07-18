include(pythoncheck.pri)
include(qmakecache_helper.pri)

# @brief getProjectName возвращает имя проекта (в верхнем регистре)
# @desc в основе имя главного pro-файла проекта, используется в *.pro и *.pri
defineReplace(getProjectName) {
    command = python -c \'import projectinfo; \
    print projectinfo.get_project_name(\"$${_PRO_FILE_}\")\'
    projectName = $${system($${command})}
    return ($${projectName})
}

# @brief getProjectVersion возвращает часть версии проекта
# @param $${1} версия проекта, заданная в виде строки:
# $${MAJOR}.$${MINOR}.$$(PATCH}.$${BUILD}
# @param $${2} часть версии проекта, которую необходимо вернуть. Допустимые
# значения: major, minor, patch, build
# @return в зависимости от $${2}, если $${2} не задано или не существует,
# то сообщение об ошибке
defineReplace(getProjectVersion) {
    # TODO: Eсли $${2} не задано, то сообщение об ошибке
    command = python -c \'import projectinfo; \
    print projectinfo.get_project_version(\"$${1}\", \"$${2}\")\'
    version = $${system($${command})}
    return ($${version})
}

# @brief writeProjectVersion запись версии проекта в .qmake.cache
# @param $${1} версия проекта, заданная в виде строки:
# $${MAJOR}.$${MINOR}.$$(PATCH}.$${BUILD}
defineTest(writeProjectVersion) {
    writeKeyValuePair(project_major_version, $${getProjectVersion($${1}, major)})
    writeKeyValuePair(project_minor_version, $${getProjectVersion($${1}, minor)})
    writeKeyValuePair(project_patch_version, $${getProjectVersion($${1}, patch)})
    writeKeyValuePair(project_build_number, $${getProjectVersion($${1}, build)})
}

# @brief getProjectBuildInfo возвращает часть информации о сборке проекта
# @param $${1} информация о сборке проекта, заданная в виде строки:
# $${BUILD_DATETIME}.$${BUILD_NUMBER}~$${DESC}
# @param $${2} часть версии проекта, которую необходимо вернуть. Допустимые
# значения: build_datetime, build_number, build_desc
# @return в зависимости от $${2}, если $${2} не задано или не существует,
# то сообщение об ошибке
defineReplace(getProjectBuildInfo) {
    # TODO: $${2} если пусто то error
    command = python -c \'import projectinfo; \
    print projectinfo.get_project_build_info(\"$${1}\", \"$${2}\")\'
    versionEx = $${system($${command})}
    return ($${versionEx})
}

# @brief writeProjectBuildInfo запись информации о сборке проекта в .qmake.cache
# @param $${1} информация о сборке проекта, заданная в виде строки:
# $${BUILD_DATETIME}.$${BUILD_NUMBER}~$${DESC}
defineTest(writeProjectBuildInfo) {
    writeKeyValuePair(project_build_datetime, $${getProjectBuildInfo($${1}, build_datetime)})
    writeKeyValuePair(project_build_number, $${getProjectBuildInfo($${1}, build_number)})
    writeKeyValuePair(project_build_desc, $${getProjectBuildInfo($${1}, build_desc)})
}

# @brief promotionValue продвижка переменной в файлы исходного кода (*.h, *.c,
# *.cpp) проекта
# @param $${1} продвигаемая переменная
# @param $${2} значение продвигаемой переменной
defineReplace(promotionValue) {
    promotionValue = $${2} $${1}=$${2}
    return ($$promotionValue)
}

# DEPRECATED
# @brief createDefinesSpecific_appVersion создание специфического определения для getAppVersion()
# @desc для продвижки APP_VERSION, APP_NAME, BUILD_YEAR, BUILD_MONTH, BUILD_DAY, BUILD_NUMBER, DESC, ARCH, OS
# в файлы исходного кода (*.h, *.c, *.cpp)
# @param $${1} строка с версией проекта
# @return
defineReplace(createDefinesSpecific_appVersion) {
    definesSpecific = \
        APP_VERSION=\\\"$${getAppVersion($${1})}\\\" \                      # версия (все поля)
        APP_NAME=\\\"$${getAppVersion($${1}, \"app_name\")}\\\" \           # название СПО
        BUILD_YEAR=\\\"$${getAppVersion($${1}, \"build_year\")}\\\" \       # год сборки
        BUILD_MONTH=\\\"$${getAppVersion($${1}, \"build_month\")}\\\" \     # месяц сборки
        BUILD_DAY=\\\"$${getAppVersion($${1}, \"build_day\")}\\\" \         # день сборки
        BUILD_NUMBER=\\\"$${getAppVersion($${1}, \"build_number\")}\\\" \   # номер сборки
        DESC=\\\"$${getAppVersion($${1}, \"desc\")}\\\" \                   # этап разработки
        ARCH=\\\"$${getAppVersion($${1}, \"arch\")}\\\" \                   # архитектура целевой платформы
        OS=\\\"$${getAppVersion($${1}, \"os\")}\\\"                         # целевая ОС
    return ($${definesSpecific})
}

# @brief getAppVersion получение версии проекта
# @desc для использования в файлах (*.pro и *.pri)
# @param $${1} строка с версией проекта
# @param $${2} параметр, показывающий какое поле версии необходимо вернуть
# @return возвращаемое значение зависит от @param $${2}
defineReplace(getAppVersion) {
    command = python -c \'import projectinfo; \
    print projectinfo.parse_project_version(\"$${1}\", $${2})\'
    appVersion = $${system($${command})}
    return ($${appVersion})
}
