include(pythoncheck.pri)

# @brief createDefinesSpecific_projectName создание специфического определения для getProjectName()
# @desc для продвижки PROJECT_NAME в файлы исходного кода (*.h, *.c, *.cpp)
defineReplace(createDefinesSpecific_projectName) {
    project_name = $${getProjectName()}
    definesSpecific = $${project_name} PROJECT_NAME=$${project_name}
    return ($${definesSpecific})
}

# @brief getProjectName получение имени проекта
# @desc для использования в файлах (*.pro и *.pri)
defineReplace(getProjectName) {
    projectName = TEST # TODO: Реализовать
    return ($${projectName})
}

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
    projectinfo_py = projectinfo
    command = python -c \'import $${projectinfo_py}; print $${projectinfo_py}.parse_project_version(\"$${1}\", $${2})\'
    appVersion = $${system($${command})}
    return ($${appVersion})
}
