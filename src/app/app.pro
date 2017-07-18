include(./../../projectinfo.pri)

QT += core

CONFIG += console

message(APP.PRO:)
message(PROJECT_NAME: $$project_name)

message(PROJECT_MAJOR_VERSION: $$project_major_version)
message(PROJECT_MINOR_VERSION: $$project_minor_version)
message(PROJECT_PATCH_VERSION: $$project_patch_version)
message(PROJECT_BUILD_NUMBER_VER: $$project_build_number_ver)

message(PROJECT_BUILD_DATETIME: $$project_build_datetime)
message(PROJECT_BUILD_NUMBER_BI: $$project_build_number_bi)
message(PROJECT_BUILD_DESC: $$project_build_desc)

DEFINES += \
    $$promotionValue(PROJECT_NAME, $$project_name, str) \
    $$promotionValue(PROJECT_NAME_IFDEF, $$project_name, ifdef) \
    \
    $$promotionValue(PROJECT_MAJOR_VERSION, $$project_major_version, int) \
    $$promotionValue(PROJECT_MINOR_VERSION, $$project_minor_version, int) \
    $$promotionValue(PROJECT_PATCH_VERSION, $$project_patch_version, int) \
    $$promotionValue(PROJECT_BUILD_NUMBER_VER, $$project_build_number_ver, int) \
    \
    $$promotionValue(PROJECT_BUILD_DATETIME, $$project_build_datetime, str) \
    $$promotionValue(PROJECT_BUILD_NUMBER_BI, $$project_build_number_bi, int) \
    $$promotionValue(PROJECT_BUILD_DESC, $$project_build_desc, str) \

TEMPLATE = app

SOURCES += \
    main.cpp
