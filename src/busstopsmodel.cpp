#include <QSettings>

#include "busstopsmodel.h"

BusStopsModel::BusStopsModel(QObject *parent) :
    QAbstractListModel(parent)
{
    // Some default values for testing
    // m_stops = {
    //     {"Vall d'Hebron", "1019", ""},
    //     {"Vall d'Hebron, 60", "1019", "60"},
    //     {"Vall d'Hebron, 73", "1019", "73"},
    //     {"Rotonda de Bellesguard", "71", "60"},
    //     {"", "0534", ""},
    //     {"", "0534", "17"},
    // };

    QSettings settings;

    // settings.beginWriteArray("stops");
    // for (int i=0; i < m_stops.size(); ++i) {
    //     settings.setArrayIndex(i);
    //     settings.setValue("name", m_stops.at(i).name);
    //     settings.setValue("stop", m_stops.at(i).stop);
    //     settings.setValue("bus",  m_stops.at(i).bus);
    //     qDebug("loop", i);
    // }
    // settings.endArray();

    int size = settings.beginReadArray("stops");
    for (int i=0; i < size; ++i) {
        settings.setArrayIndex(i);
        BusStop stop = {
            settings.value("name").toString(),
            settings.value("stop").toString(),
            settings.value("bus").toString(),
        };
        m_stops.append(stop);
    }

}

QVariant BusStopsModel::data(const QModelIndex& index, int role) const
{
    switch (role) {
    case NameRole:
        return m_stops.at(index.row()).name;
    case StopRole:
        return m_stops.at(index.row()).stop;
    case BusRole:
        return m_stops.at(index.row()).bus;
    }
    return QVariant();
}

int BusStopsModel::rowCount(const QModelIndex&) const
{
    return m_stops.count();
}
