include(./../../projectinfo.pri)

QT += core

CONFIG += console

message(APP.PRO:)
message(PROJECT_MAJOR_VERSION: $${project_major_version})
message(PROJECT_MINOR_VERSION: $${project_minor_version})
message(PROJECT_PATCH_VERSION: $${project_patch_version})
message(PROJECT_BUILD_NUMBER: $${project_build_number})

message(PROJECT_NAME: $${project_name})
message(PROJECT_BUILD_DATETIME: $${build_datetime})
message(PROJECT_BUILD_NUMBER: $${build_number})
message(PROJECT_BUILD_DESC: $${build_desc})

#DEFINES += \
#    PROJECT_MAJOR_VERSION=\\\"$$project_major_version\\\" \
#    PROJECT_MINOR_VERSION=\\\"$$project_minor_version\\\" \
#    PROJECT_PATCH_VERSION=\\\"$$project_patch_version\\\" \
#    PROJECT_BUILD_NUMBER=\\\"$$project_build_number\\\" \
#    \
#    PROJECT_NAME=\\\"$$project_name\\\" \
#    PROJECT_BUILD_DATETIME=\\\"$$build_datetime\\\" \
#    PROJECT_BUILD_NUMBER=\\\"$$build_number\\\" \
#    PROJECT_BUILD_DESC=\\\"$$build_desc\\\"

#    $$promotionValue(PROJECT_NAME, $$project_name)

TEMPLATE = app

SOURCES += \
    main.cpp
