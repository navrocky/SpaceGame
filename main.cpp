#include <QQmlApplicationEngine>
#include <QGuiApplication>
//#include <QDebug>
//#include <QQuickView>
#include <QtQml>
#include "xmlloader.h"

static QObject* XmlLoaderSingletonProvider(QQmlEngine*, QJSEngine*)
{
    return new XmlLoader;
}

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    qmlRegisterSingletonType<XmlLoader>("SpaceGame", 1, 0, "XmlLoader", XmlLoaderSingletonProvider);
    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/main.qml")));
    return app.exec();
}
