include(src/projectinfo.pri)
include(src/qmake_helper.pri)

recreate_qmake_cache()

TEMPLATE = subdirs

SUBDIRS += \
    src

VERSION = 1.2.3.4
BUILD_INFO = 2017-07-11_11:50:48.2~gi2

write_project_info(,, $$BUILD_INFO)

#OTHER_FILES += \
#    doc/projectinfo.py
