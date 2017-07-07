include(projectinfo.pri)
include(sysinfo.pri)

QT += core

CONFIG += console

VERSION = r-357nm_2016.12.08.1~gi2_i386_linux          

DEFINES += \
    $${createDefinesSpecific_osVersion()} \
    $${createDefinesSpecific_appVersion($${VERSION})}

TEMPLATE = app

SOURCES += \
    main.cpp

osVersion = $${getOsVersion()}

# в зависимости от конкретной версии ОС
contains(osVersion, MSVS) {
    TARGET = $${TARGET}_MSVS
}
#

# в зависимости от нескольких ОС
os = $$find(osVersion, DEBIAN) $$find(osVersion, UBUNTU)
count(os, 1) {
    TARGET = $${TARGET}_DEBIAN_UBUNTU
}
#

OTHER_FILES += \
    projectinfo.py \
    sysinfo.py
