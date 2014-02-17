#ifdef QT_QML_DEBUG
#include <QtQuick>
#endif

#include <QGuiApplication>
#include <QQuickView>

// Argh, do I need the whole module for qmlRegisterType?? Insane, but seems so.
#include <QtQml>

#include <sailfishapp.h>

#include "busstopsmodel.h"

int main(int argc, char *argv[])
{
    qmlRegisterType<BusStopsModel>("My.BusStopsModel", 0, 1, "BusStopsModel");
    QScopedPointer<QGuiApplication> app(SailfishApp::application(argc, argv));
    QScopedPointer<QQuickView> view(SailfishApp::createView());

    view->setSource(SailfishApp::pathTo("qml/main.qml"));

    view->showFullScreen();
    return app->exec();
}
