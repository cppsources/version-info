include(projectinfo.pri)

exists($$OUT_PWD/.qmake.cache) {
    unix: system(rm -rf $$OUT_PWD/.qmake.cache)
    win32: system(DEL /Q /F $$OUT_PWD/.qmake.cache) # TODO: Протестировать
}

TEMPLATE = subdirs

SUBDIRS += \
    src

VERSION = 1.2.3.4
BUILD_INFO = 2017-07-11_11:50:48.2~gi2

writeProjectName()
writeProjectVersion($$VERSION)
writeProjectBuildInfo($$BUILD_INFO)

OTHER_FILES += \
    projectinfo.py
