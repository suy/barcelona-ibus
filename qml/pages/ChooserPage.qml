import QtQuick 2.0
import Sailfish.Silica 1.0
import My.BusStopsModel 0.1

Page {
    id: page
	property string stopUrl: "http://www.tmb.cat/mobile/pwtmb?action=ibus_parada&parada=%1"
	property string busUrl:  "http://www.tmb.cat/mobile/pwtmb?action=info_parada&parada=%1&busNumber=%2"

	SilicaListView {
		id: stopsList
		anchors.fill: parent
		model: BusStopsModel {id: stopsModel}

		header: PageHeader { title: qsTr("Configured Stops")}

		ViewPlaceholder {
			enabled: stopsModel.rowCount() === 0
			text: qsTr("Add bus stops from the menu")
		}

		delegate: ListItem {
			id: listItem
			menu: contextMenuComponent
			contentHeight: Theme.itemSizeMedium
			ListView.onAdd:    AddAnimation    { target: listItem }
			ListView.onRemove: RemoveAnimation { target: listItem }

			Label {
				id: entryLabel
				text: {
					name? name: bus?
					qsTr("Stop %1. Bus %2.").arg(stop).arg(bus) :
					qsTr("Stop %1.").arg(stop)
				}
				x: Theme.paddingLarge
				font.pixelSize: Theme.fontSizeMedium
				truncationMode: TruncationMode.Fade
			}
			onClicked: {
				webPage.pageUrl = bus?
                    busUrl.arg(stop).arg(bus):
                    stopUrl.arg(stop);
				pageStack.navigateForward(PageStackAction.Animated);
			}

			Component {
				id: contextMenuComponent
				ContextMenu {
					MenuItem {
						text: qsTr("Edit")
					}
					MenuItem {
						text: qsTr("Delete")
						onClicked: stopsModel.removeRows(index);
						// Cannot call method 'removeRows' of undefined
						// onClicked: {
						//     remorseAction(qsTr("Deleting"), function() {
						//         stopsModel.removeRows(index);
						//     })
						// }
					}
				}
			}
		}
	}
}
