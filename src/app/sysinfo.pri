# @brief createDefinesSpecific_osVersion создание специфического определения для getOsVersion()
# @desc для продвижки OS_VERSION в файлы исходного кода (*.h, *.c, *.cpp)
defineReplace(createDefinesSpecific_osVersion) {
    definesSpecific = $${getOsVersion()} OS_VERSION=$${getOsVersion()}
    return ($${definesSpecific})
}

# @brief getOsVersion определение версии ОС
# @desc для использования в файлах (*.pro и *.pri)
defineReplace(getOsVersion) {
# Cпособ включения скрипта на Python в файл *.pri (experimental)
#    line_1  = "echo '\43!/bin/python\n\n"
#    line_2  = "import os\n\n"
#    line_3  = "def get_os_version():\n"
#    line_4  = "\tos_version = \"n/a\"\n"
#    line_5  = "\tif os.name == \"posix\":\n"
#    line_6  = "\t\tstr = os.popen(\"uname -a\").read()\n"
#    line_7  = "\t\tif str.find(\"Debian\") != -1:\n"
#    line_8  = "\t\t\tos_version = \"DEBIAN\"\n"
#    line_9  = "\t\telif str.find(\"vniins\") != -1:\n"
#    line_10 = "\t\t\tos_version = \"MSVS\"\n"
#    line_11 = "\t\telif str.find(\"Ubuntu\") != -1:\n"
#    line_12 = "\t\t\tos_version = \"UBUNTU\"\n"
#    line_13 = "\treturn os_version\n"
#    line_14 = "print(get_os_version())'"
#    file_py = $${line_1}$${line_2}$${line_3}$${line_4}$${line_5}$${line_6}$${line_7}$${line_8}$${line_9}$${line_10}$${line_11}$${line_12}$${line_13}$${line_14}

#    command = $${file_py} | python
#

# TODO: разобраться как указывать абсолютный путь к файлу
#    sysinfo_py = $${_PRO_FILE_PWD_}/sysinfo
    sysinfo_py = sysinfo
    command = python -c \'import $${sysinfo_py}; print $${sysinfo_py}.get_os_version()\'

    osVersion = $${system($${command})}
    return ($${osVersion})
}
