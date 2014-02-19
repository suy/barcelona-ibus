# The name of your app.
# NOTICE: name defined in TARGET has a corresponding QML filename.
#         If name defined in TARGET is changed, following needs to be
#         done to match new name:
#         - corresponding QML filename must be changed
#         - desktop icon filename must be changed
#         - desktop filename must be changed
#         - icon definition filename in desktop file must be changed
TARGET = harbour-barcelona-ibus

QT = core gui qml quick
CONFIG += sailfishapp c++11

SOURCES += src/main.cpp src/busstopsmodel.cpp
HEADERS += src/busstopsmodel.h

OTHER_FILES += qml/main.qml \
    qml/cover/CoverPage.qml \
    qml/pages/WebPage.qml \
    qml/pages/ChooserPage.qml \
    qml/pages/EditDialog.qml \
    rpm/harbour-barcelona-ibus.spec \
    rpm/harbour-barcelona-ibus.yaml \
    harbour-barcelona-ibus.desktop
