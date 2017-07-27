include(./../projectinfo.pri)

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
    $$promotion_value(PROJECT_NAME, $$project_name, STR) \
    $$promotion_value(PROJECT_NAME_IFDEF, $$project_name, IFDEF) \
    \
    $$promotion_value(PROJECT_MAJOR_VERSION, $$project_major_version, INT) \
    $$promotion_value(PROJECT_MINOR_VERSION, $$project_minor_version, INT) \
    $$promotion_value(PROJECT_PATCH_VERSION, $$project_patch_version, INT) \
    $$promotion_value(PROJECT_BUILD_NUMBER_VER, $$project_build_number_ver, INT) \
    \
    $$promotion_value(PROJECT_BUILD_DATETIME, $$project_build_datetime, STR) \
    $$promotion_value(PROJECT_BUILD_NUMBER_BI, $$project_build_number_bi, INT) \
    $$promotion_value(PROJECT_BUILD_DESC, $$project_build_desc, STR)

TEMPLATE = app

SOURCES += \
    main.cpp
