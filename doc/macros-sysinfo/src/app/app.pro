include(projectinfo.pri)
include(sysinfo.pri)

QT += core

CONFIG += console

VERSION = 1.2.3.4
VERSION_EX = r-357nm_2016.12.08.1~gi2_i386_linux

FULLNAME = Full Name            # полное название приложения или библиотеки
SHORTNAME = Short Name          # краткое название приложения или библиотеки
COMPILER_VER = g++ 4.9.2        # версия компилятора
BUILD_DATETIME = 2017.07.07, 14:00:00 # дата и время сборки
QT_VERSION_ = Qt $${QT_VERSION} # версия Qt
3RD_PARTY_LIB = Qwt 6.0.0, Poppler 5.1.2
RAW_DATA = r-357nm_2016.12.08.1~gi2_i386_linux
VERSION_EX_ = $${FULLNAME}$${SHORTNAME}$${COMPILER_VER}$${BUILD_DATETIME}$${QT_VERSION_}$${3RD_PARTY_LIB}$${RAW_DATA}
message($${VERSION_EX_})

DEFINES += \
    $${createDefinesSpecific_osVersion()} \
    $${createDefinesSpecific_appVersion($${VERSION_EX})}

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
