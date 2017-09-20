#include "mainwindow.h"
#include "ui_mainwindow.h"

MainWindow::MainWindow(QWidget *parent) :
    QMainWindow(parent),
    ui(new Ui::MainWindow)
{
    ui->setupUi(this);

    // Добавление номера АРМ и информации о сборке в заголовок главного окна
    QString buildNumber = "3";          // взять из $$PROJECT_BUILD_NUMBER
    QString buildDate = "08.08.2017";   // взять из $$PROJECT_BUILD_DATETIME

    QString windowTitleDecorate = tr("%0 (сборка %1 от %2)")
            .arg(windowTitle.arg(CommonConfHelper::getWorkstationsNumber()))
            .arg(buildNumber)
            .arg(buildDate);

    // Передача заголовка (из конф. файла) производного окна абстрактному окну
    pMainWindow->setWindowTitleFromMainWindowPlugin(windowTitleDecorate);

    // Передача click на кнопку, соответствующую активному MainWidgetPlugin, при запуске СПО
    pMainWindow->setDefaultActiveMainWidgetPlugin();

}

MainWindow::~MainWindow()
{
    delete ui;
}
