include(./../environment.pri)
include(./../projectinfo.pri)

QT += core

greaterThan(QT_MAJOR_VERSION, 4): QT += widgets

TEMPLATE = lib

CONFIG += static

SOURCES += \
    main.cpp
