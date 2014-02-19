#include <QSettings>

#include "busstopsmodel.h"

BusStopsModel::BusStopsModel(QObject *parent) :
    QAbstractListModel(parent)
{
    QSettings settings;

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

bool BusStopsModel::removeRows(int row, int count, const QModelIndex& parent)
{
    Q_ASSERT_X(m_stops.size() > row, Q_FUNC_INFO, "Too large row index");
    // first = last in our case
    beginRemoveRows(parent, row, row);
    m_stops.remove(row);
    endRemoveRows();
    Q_UNUSED(count);
    save();
    return true;
}

void BusStopsModel::setRow(int row, QString name, QString stop, QString bus)
{
    Q_ASSERT_X(m_stops.size() > row, Q_FUNC_INFO, "Row index too large");
    m_stops[row].name = name;
    m_stops[row].stop = stop;
    m_stops[row].bus = bus;
    save();

    QVector<int> roles = {NameRole, BusRole, StopRole};
    emit dataChanged(index(row), index(row), roles);
}

void BusStopsModel::save()
{
    QSettings settings;
    settings.beginWriteArray("stops");
    for (int i=0; i < m_stops.size(); ++i) {
        settings.setArrayIndex(i);
        settings.setValue("name", m_stops.at(i).name);
        settings.setValue("stop", m_stops.at(i).stop);
        settings.setValue("bus",  m_stops.at(i).bus);
    }
    settings.endArray();
}

void BusStopsModel::addDefaults()
{
    // Some default values for testing
    int firstAffected = m_stops.size();
    m_stops += {
        {"Vall d'Hebron", "1019", ""},
        {"Vall d'Hebron, 60", "1019", "60"},
        {"Vall d'Hebron, 73", "1019", "73"},
        {"Rotonda de Bellesguard", "71", "60"},
        {"", "0534", ""},
        {"", "0534", "17"},
    };
    beginInsertRows(QModelIndex(), firstAffected, m_stops.size()-1);
    save();
    endInsertRows();
}

void BusStopsModel::addEntry(QString name, QString stop, QString bus)
{
    int firstAffected = m_stops.size();
    m_stops += {
        {name, stop, bus},
    };
    beginInsertRows(QModelIndex(), firstAffected, m_stops.size()-1);
    save();
    endInsertRows();
}

