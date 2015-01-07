#ifndef XMLLOADER_H
#define XMLLOADER_H

#include <QObject>
#include <QVariantMap>

class XmlLoader : public QObject
{
    Q_OBJECT
public:
    explicit XmlLoader(QObject *parent = 0);

signals:

public slots:
    QVariantMap loadXml(const QString& fileName);
};

#endif // XMLLOADER_H
