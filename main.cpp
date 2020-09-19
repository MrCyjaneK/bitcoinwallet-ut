#include <QGuiApplication>
#include <QCoreApplication>
#include <QUrl>
#include <QString>
#include <QProcess>
#include <QQuickView>
#include <QStandardPaths>
#include <QDir>
#include <QtQml>
#include <stdlib.h>
#include <unistd.h>
#include <sys/wait.h>
#include <iostream>
#include <pthread.h>
//#include "process.h"

int main(int argc, char *argv[])
{
    QGuiApplication *app = new QGuiApplication(argc, (char**)argv);

    //qmlRegisterType<Process>("Process", 1, 0, "Process");

    app->setApplicationName("bitcoinwallet.mrcyjanek");

    qDebug() << "Starting app from main.cpp";

    QQuickView *view = new QQuickView();
    view->setSource(QUrl("qrc:/Main.qml"));
    view->setResizeMode(QQuickView::SizeRootObjectToView);
    view->show();

    qDebug() << "Creating directory";
    QDir().mkdir(QStandardPaths::writableLocation(QStandardPaths::AppDataLocation));

    qDebug() << "Starting bitcoind.";

    // Start the process
    QProcess process;
    process.start("bitcoind -prune=2200 -daemon -server -datadir="+QStandardPaths::writableLocation(QStandardPaths::AppDataLocation));
    //process.start("bitcoind -daemon -server -datadir=" + QStandardPaths::writableLocation(QStandardPaths::AppDataLocation));
    qDebug() << "Started bitcoind.";
    // qDebug() << QStandardPaths::writableLocation(QStandardPaths::AppDataLocation);
    // /home/phablet/.local/share/bitcoinwallet.mrcyjanek

    /* Command line options:
     * -server - to accept JSON-RPC commands
     * -rpcwhitelist=127.0.0.1 - allow only local connections
     * -rpcuser=phablet
     * -rpcpassword= - yeah.
     * maybe we should use -rpccookiefile ?
     * -printtoconsole - let's print to console and debug
    */


    return app->exec();
}
