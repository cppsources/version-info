#include <QCoreApplication>
#include <QDebug>

int main(int argc, char *argv[])
{
    QCoreApplication a(argc, argv);

    qDebug() << "QCoreApplication: ";
    qDebug() << "PROJECT_NAME: " << PROJECT_NAME;

    qDebug() << "PROJECT_MAJOR_VERSION: " << PROJECT_MAJOR_VERSION;
    qDebug() << "PROJECT_MINOR_VERSION: " << PROJECT_MINOR_VERSION;
    qDebug() << "PROJECT_PATCH_VERSION: " << PROJECT_PATCH_VERSION;
    qDebug() << "PROJECT_BUILD_NUMBER_VER: " << PROJECT_BUILD_NUMBER_VER;

    qDebug() << "PROJECT_BUILD_DATETIME: " << PROJECT_BUILD_DATETIME;
    qDebug() << "PROJECT_BUILD_NUMBER_BI: " << PROJECT_BUILD_NUMBER_BI;
    qDebug() << "PROJECT_BUILD_DESC: " << PROJECT_BUILD_DESC;

#if PROJECT_NAME_IFDEF == PROJECT_VERSION
    qDebug() << 1;
#else
    qDebug() << 2;
#endif
    return a.exec();
}
