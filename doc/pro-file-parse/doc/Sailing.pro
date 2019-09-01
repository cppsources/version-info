TEMPLATE = subdirs

SUBDIRS = \
    SailingLibrariesCommon \
    SailingLibrariesDevices \
    SailingLibrariesSessions \
    SailingLibrariesGUI \
    SailingBinaries

SailingLibrariesDevices.depends=SailingLibrariesCommon
SailingLibrariesSessions.depends=SailingLibrariesDevices
SailingBinaries.depends=SailingLibrariesSessions 
SailingLibrariesGUI.depends=SailingLibrariesCommon SailingLibrariesDevices SailingLibrariesSessions

OTHER_FILES += \
    config.pri
