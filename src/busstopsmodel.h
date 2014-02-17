#ifndef BUSSTOPSMODEL_H
#define BUSSTOPSMODEL_H

#include <QAbstractItemModel>

struct BusStop {
    QString name;
    QString stop;
    QString bus;
};

class BusStopsModel : public QAbstractListModel
{
    Q_OBJECT
    public:
        explicit BusStopsModel(QObject *parent = 0);

        QHash<int, QByteArray> roleNames() const Q_DECL_FINAL
        {
            return {
                {NameRole, "name"},
                {StopRole, "stop"},
                {BusRole,  "bus"},
            };
        }

        QVariant data(const QModelIndex& index, int role) const Q_DECL_FINAL;
        int rowCount(const QModelIndex& parent = QModelIndex()) const Q_DECL_FINAL;
        Q_INVOKABLE bool removeRows(int row, int count=1,
                const QModelIndex& parent = QModelIndex()) Q_DECL_FINAL;

    private:
        void save();

        enum {NameRole = Qt::UserRole+1, BusRole, StopRole};

        QVector<BusStop> m_stops;

};

#endif // BUSSTOPSMODEL_H
