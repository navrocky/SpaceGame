#include "xmlloader.h"

#include <QXmlStreamReader>
#include <QFile>
#include <QDebug>

XmlLoader::XmlLoader(QObject *parent)
    : QObject(parent)
{
}

QVariantMap XmlLoader::loadXml(const QString &fileName)
{
    QVariantMap m;
    QList<QVariantMap> stack;

    QFile f(fileName);
    if (!f.open(QFile::ReadOnly))
    {
        qCritical() << "<166dfd87> Cant read file" << fileName;
        return QVariantMap();
    }

    QXmlStreamReader xml(&f);
    while (!xml.atEnd())
    {
        QXmlStreamReader::TokenType tt = xml.readNext();
        if (tt == QXmlStreamReader::StartElement)
        {
            if (!m.empty())
            {
                stack.push_back(m);
                m = QVariantMap();
            }
            m["name"] = xml.name().toString();

            QVariantMap attrMap;
            foreach (const QXmlStreamAttribute& attr, xml.attributes())
            {
                attrMap[attr.name().toString()] = attr.value().toString();
            }
            m["attrs"] = attrMap;
        }
        else if (tt == QXmlStreamReader::EndElement)
        {
            if (!stack.empty())
            {
                QVariantMap prevMap = stack.last();
                stack.pop_back();
                QVariantList children = prevMap["children"].toList();
                children.append(m);
                m = prevMap;
                m["children"] = children;
            }
        }
    }
    if (xml.hasError())
    {
        qCritical() << "<767691c4> Xml error" << xml.errorString();
        return QVariantMap();
    }
    return m;
}
