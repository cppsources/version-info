#include <QCoreApplication>
#include <QDebug>

int main(int argc, char *argv[])
{
    QCoreApplication a(argc, argv);
    qDebug() << "AppVersion:" << APP_VERSION;
    qDebug() << "AppName:" << APP_NAME;
    qDebug() << "BuildYear:" << BUILD_YEAR;
    qDebug() << "BuildMonth:" << BUILD_MONTH;
    qDebug() << "BuildDay:" << BUILD_DAY;
    qDebug() << "BuildNumber:" << BUILD_NUMBER;
    qDebug() << "Desc:" << DESC;
    qDebug() << "Arch:" << ARCH;
    qDebug() << "Os:" << OS << "\n";

#if APP_NAME == r-357nm
    qDebug() << 123;
#endif

    QString osVersion;
#if OS_VERSION == DEBIAN
    osVersion = "Debian";
#elif OS_VERSION == UBUNTU
    osVersion = "UBUNTU";
#elif OS_VERSION == MSVS
    osVersion = "MSVS";
#endif
    qDebug() << "OsVersion:" << osVersion.toAscii().data();
    return a.exec();
}
