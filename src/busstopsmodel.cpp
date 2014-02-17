#include "busstopsmodel.h"

BusStopsModel::BusStopsModel(QObject *parent) :
    QAbstractListModel(parent)
{
    m_stops = {
        {"Vall d'Hebron", "1019", ""},
        {"Vall d'Hebron, 60", "1019", "60"},
        {"Vall d'Hebron, 73", "1019", "73"},
        {"Rotonda de Bellesguard", "71", "60"},
        {"", "0534", ""},
        {"", "0534", "17"},
    };
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
