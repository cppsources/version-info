include(../config.pri)

QT += core gui network xml

# обеспечение подключения модулей в зависимости от версии ОС
osVersion = $${getOsVersion()}
os = $$find(osVersion, MSVS)
count(os, 1) {
    QT += multimedia
}

os = $$find(osVersion, DEBIAN) $$find(osVersion, UBUNTU)
count(os, 1) {
    INCLUDEPATH += /usr/include/QtMultimediaKit
    LIBS += -lQtMultimediaKit
}

os = $$find(osVersion, ASTRA)
count(os, 1) {
    INCLUDEPATH += /usr/include/qt4/QtMultimedia
}
#

DEFINES += \
    $${createDefinesSpecific_osVersion()}    # обеспечение зависимости от версии ОС

CONFIG += mobility qwt


TEMPLATE = lib
TARGET = $$qtLibraryTarget(SailingAuditoryControl)

INCLUDEPATH += ./ /usr/local/include ../ ../../SailingLibrariesCommon ../../SailingLibrariesSessions/ ../../SailingLibrariesDevices ../../Sailing3rdParty  ../SailingLibrariesCommon/SailingSoundchecker ../../SailingLibrariesDevices/SailingKVComplex
LIBS		+=      -lfftw3 \
                        -L/usr/local/lib  -Wl,-rpath=/usr/local/lib

QMAKE_CXXFLAGS += -fPIC



unix:!macx: LIBS += -L/usr/local/qwt-6.0.0/lib -lqwt
#include(qwt.pri)
#include(dsp.pri)
#include(channel_processing.pri)
#include(my_snmp.pri)

SOURCES += \
    ChannelProcessing/Logger.cpp \
    ChannelProcessing/PackageManager.cpp \
    ChannelProcessing/DataSources/AbstractDataSource.cpp \
    ChannelProcessing/DataSources/AbstractDataSourceFactory.cpp \
    ChannelProcessing/DataSources/AbstractDataSourceSettingWidget.cpp \
    ChannelProcessing/DataSources/AudioSource.cpp \
    ChannelProcessing/DataSources/AudioSourceFactory.cpp \
    ChannelProcessing/DataSources/AudioSourceSettingWidget.cpp \
    ChannelProcessing/DataSources/UdpEthSourceFactory.cpp \
    ChannelProcessing/DataSources/UdpEthSource.cpp \
    ChannelProcessing/DataSources/UdpEthSourceSettingWidget.cpp \
    ChannelProcessing/DataSources/UdpResiver.cpp \
    ChannelProcessing/Parsers/RpuRtpParser.cpp \
    ChannelProcessing/Parsers/AbstractParser.cpp \
    ChannelProcessing/Parsers/AbstractParserFactory.cpp \
    ChannelProcessing/Parsers/RpuRtpParserFactory.cpp \
    ChannelProcessing/Converter/AbstractConverter.cpp \
    ChannelProcessing/Series/HistorySeries.cpp \
    ChannelProcessing/TextPrinter.cpp \
    ChannelProcessing/Plot/HistoryPlot.cpp \
    ChannelProcessing/Plot/SimplePlot.cpp \
    ChannelProcessing/Series/SimpleSeries.cpp \
    ChannelProcessing/ChannelData.cpp \
    ChannelProcessing/ChannelResiev.cpp \
    ChannelProcessing/Synchronizer.cpp \
    ChannelProcessing/Converter/TemporalProc.cpp \
    ChannelProcessing/Parsers/DataParser.cpp \
    ChannelProcessing/Parsers/RTPmsg.cpp \
    ChannelProcessing/Plot/AbstractPlot.cpp \
    ChannelProcessing/Plot/DataFinishing.cpp \
    ChannelProcessing/Plot/DynamicPlot.cpp \
    ChannelProcessing/Plot/SpectrPlot.cpp \
    ChannelProcessing/Plot/ValuePlot.cpp \
    ChannelProcessing/Series/DynamicSeries.cpp \
    ChannelProcessing/Series/Point3F.cpp \
    ChannelProcessing/Series/SpectrSeries.cpp \
    ChannelProcessing/Series/ValueSeries.cpp \
    ChannelProcessing/Sound/SoundData.cpp \
    ChannelProcessing/Sound/SoundPlayer.cpp \
    ChannelProcessing/Converter/AbstractConverterFactory.cpp \
    ChannelProcessing/Converter/AbstractConverterSettingWidget.cpp \
    ChannelProcessing/Converter/SpectrumConverter.cpp \
    ChannelProcessing/Converter/SpectrumConverterFactory.cpp \
    ChannelProcessing/Converter/AudioPlayerConverter.cpp \
    ChannelProcessing/Converter/AudioPlayerConverterFactory.cpp \
    ChannelProcessing/Converter/SpectrumConverterSettingWidget.cpp \
    ChannelProcessing/Converter/AudioPlayerConverterSettingWidget.cpp \
    ChannelProcessing/OperationChannel.cpp \
    ChannelProcessing/Converter/AudioPlayerConverterControlWidget.cpp \
    ChannelProcessing/DataSources/UdpResiverNew.cpp \
    ChannelProcessing/DataSources/UdpResiverNew2.cpp \
    ChannelProcessing/Converter/AbstractStreamConverterFactory.cpp \
    ChannelProcessing/Converter/AbstractStreamConverterSettingWidget.cpp \
    ChannelProcessing/DataContainer.cpp \
    DSP/AbstractDebugger.cpp \
    DSP/AbstractItemDSP.cpp \
    DSP/CommonDemod.cpp \
    DSP/CommonResamplerCPU.cpp \
    DSP/FFT.cpp \
    DSP/ItemsDSP.cpp \
    DSP/MemoryAllocator.cpp \
    DSP/WindowFunction.cpp \
    DSP/Function.cpp \
    DSP/ConverterDataStream.cpp \
    DSP/AbstractDemod.cpp\
    OpenChannels.cpp \
    auditorycontrolplugin.cpp \
    auditorycontroltraywidget.cpp \
    auditoryform.cpp \
    DSP/FileDebugger.cpp \
    ChannelProcessing/Converter/ARU_VC.cpp \
    ChannelProcessing/Converter/StreamConverterVC.cpp \
    ChannelProcessing/Converter/StreamConverter.cpp \
    DSP/ResamplerComplexWithFreqTransform.cpp \
    ChannelProcessing/Converter/DataFileConservation.cpp \
    ChannelProcessing/Converter/DataFileConservationFactory.cpp \
    ChannelProcessing/Converter/DataFileConservationSettingWidget.cpp \
    DSP/AcousticControlStreamlConverter.cpp \
    auditorycontrol.cpp \
    Visualizer/settings_view.cpp \
    Visualizer/signal_view.cpp

HEADERS += \
    ChannelProcessing/Logger.h \
    ChannelProcessing/PackageManager.h \
    ChannelProcessing/DataSources/AbstractDataSource.h \
    ChannelProcessing/DataSources/AbstractDataSourceFactory.h \
    ChannelProcessing/DataSources/AbstractDataSourceSettingWidget.h \
    ChannelProcessing/DataSources/AudioSource.h \
    ChannelProcessing/DataSources/AudioSourceFactory.h \
    ChannelProcessing/DataSources/AudioSourceSettingWidget.h \
    ChannelProcessing/DataSources/UdpEthSourceFactory.h \
    ChannelProcessing/DataSources/UdpEthSource.h \
    ChannelProcessing/DataSources/UdpEthSourceSettingWidget.h \
    ChannelProcessing/DataSources/UdpResiver.h \
    ChannelProcessing/Parsers/RpuRtpParser.h \
    ChannelProcessing/Parsers/AbstractParser.h \
    ChannelProcessing/Parsers/AbstractParserFactory.h \
    ChannelProcessing/Parsers/RpuRtpParserFactory.h \
    ChannelProcessing/Converter/AbstractConverter.h \
    ChannelProcessing/Plot/HistoryPlot.h \
    ChannelProcessing/Series/HistorySeries.h \
    ChannelProcessing/TextPrinter.h \
    ChannelProcessing/Plot/SimplePlot.h \
    ChannelProcessing/Series/SimpleSeries.h \
    ChannelProcessing/ChannelData.h \
    ChannelProcessing/ChannelResiev.h \
    ChannelProcessing/Synchronizer.h \
    ChannelProcessing/Converter/TemporalProc.h \
    ChannelProcessing/Parsers/DataParser.h \
    ChannelProcessing/Parsers/RTPmsg.h \
    ChannelProcessing/Plot/AbstractPlot.h \
    ChannelProcessing/Plot/DataFinishing.h \
    ChannelProcessing/Plot/DynamicPlot.h \
    ChannelProcessing/Plot/SpectrPlot.h \
    ChannelProcessing/Plot/ValuePlot.h \
    ChannelProcessing/Series/DynamicSeries.h \
    ChannelProcessing/Series/Point3F.h \
    ChannelProcessing/Series/SpectrSeries.h \
    ChannelProcessing/Series/ValueSeries.h \
    ChannelProcessing/Series/SignalData.h \
    ChannelProcessing/Sound/SoundData.h \
    ChannelProcessing/Sound/SoundPlayer.h \
    ChannelProcessing/ChannelProcessing_global.h \
    ChannelProcessing/Converter/AbstractConverterFactory.h \
    ChannelProcessing/Converter/AbstractConverterSettingWidget.h \
    ChannelProcessing/Converter/SpectrumConverter.h \
    ChannelProcessing/Converter/SpectrumConverterFactory.h \
    ChannelProcessing/Converter/AudioPlayerConverter.h \
    ChannelProcessing/Converter/AudioPlayerConverterFactory.h \
    ChannelProcessing/Converter/SpectrumConverterSettingWidget.h \
    ChannelProcessing/Converter/AudioPlayerConverterSettingWidget.h \
    ChannelProcessing/OperationChannel.h \
    ChannelProcessing/ComplexData.h \
    ChannelProcessing/Converter/AudioPlayerConverterControlWidget.h \
    ChannelProcessing/DataSources/UdpResiverNew.h \
    ChannelProcessing/DataSources/UdpResiverNew2.h \
    ChannelProcessing/Converter/AbstractStreamConverterFactory.h \
    ChannelProcessing/Converter/AbstractStreamConverterSettingWidget.h \
    ChannelProcessing/DataContainer.h \
    ChannelProcessing/Sleeper.h \
    DSP/AbstractDebugger.h \
    DSP/AbstractItemDSP.h \
    DSP/CommonDemod.h \
    DSP/CommonResamplerCPU.h \
    DSP/FFT.h \
    DSP/ItemData.h \
    DSP/ItemsDSP.h \
    DSP/MemoryAllocator.h \
    DSP/WindowFunction.h \
    DSP/DSP_global.h \
    DSP/TypeData.h \
    DSP/Function.h \
    DSP/ConverterDataStream.h \
    DSP/AbstractDemod.h \
    DSP/ItemLineDalay.h\
    OpenChannels.h \
    auditorycontrolplugin.h \
    auditorycontroltraywidget.h \
    auditoryform.h \
    DSP/FileDebugger.h \
    ChannelProcessing/Converter/ARU_VC.h \
    ChannelProcessing/Converter/StreamConverterVC.h \
    ChannelProcessing/Converter/StreamConverter.h \
    DSP/ResamplerComplexWithFreqTransform.h \
    ChannelProcessing/Converter/DataFileConservation.h \
    ChannelProcessing/Converter/DataFileConservationFactory.h \
    ChannelProcessing/Converter/DataFileConservationSettingWidget.h \
    DSP/AcousticControlStreamlConverter.h \
    auditorycontrol.h \
    Visualizer/settings_view.h \
    Visualizer/signal_view.h


unix:!macx: LIBS += -L$$DESTDIR -lSailingDevicesCommon
unix:!macx: LIBS += -L$$DESTDIR -lSailingReceiver
unix:!macx: LIBS += -L$$DESTDIR -lSailingGUICommon
unix:!macx: LIBS += -L$$DESTDIR -lSailingKVComplex
unix:!macx: LIBS += -L$$DESTDIR -lSailingKVComplexSessions
unix:!macx: LIBS += -L$$DESTDIR -lSailingBaikal

unix:!macx: LIBS += -L$$OUT_PWD/../../SailingLibrariesCommon/SailingSoundchecker/ -lSailingSoundchecker

INCLUDEPATH += $$PWD/../../SailingLibrariesCommon/SailingSoundchecker
DEPENDPATH += $$PWD/../../SailingLibrariesCommon/SailingSoundchecker

FORMS += \
    auditoryform.ui \
    Visualizer/ui/settingsdialog.ui \
    Visualizer/ui/signal_mainwindow.ui

RESOURCES += \
    resourceAudid.qrc

