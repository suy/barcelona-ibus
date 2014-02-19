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
			// FIXME: only works as a binding if it's a property.
			enabled: stopsModel.rowCount() === 0
			text: qsTr("Add bus stops from the menu")
		}

		PullDownMenu {
			MenuItem {
				text: qsTr("Add new entry")
				onClicked: {
					var dialog = pageStack.push("EditDialog.qml",
						{"name": "", "stop": "", "bus": "", "index": -1}
					);
					dialog.accepted.connect(function() {
						console.log("Adding", dialog.index, dialog.name, dialog.stop, dialog.bus);
						// stopsModel.setRow(dialog.index, dialog.name, dialog.stop, dialog.bus);
					});
				}
			}
			MenuItem {
				text: qsTr("Add default values")
				onClicked: stopsModel.addDefaults();
			}
		}

		delegate: ListItem {
			id: listItem
			// menu: contextMenuComponent
			menu: ContextMenu {
				MenuItem {
					text: qsTr("Edit")
					onClicked: {
						var dialog = pageStack.push("EditDialog.qml",
							{"name": name, "stop": stop, "bus": bus, "index": index}
						);
						dialog.accepted.connect(function() {
							stopsModel.setRow(dialog.index, dialog.name, dialog.stop, dialog.bus);
						});
					}
				}
				MenuItem {
					text: qsTr("Delete")
					onClicked: {
						remorseAction(qsTr("Deleting"), function() {
						stopsModel.removeRows(index);
						}, 5000);
					}
				}
			}
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

			// With the same contents as the inline context menu, it fails to
			// find the id of the model, or the remorseAction fails strangely.
			// Component {
			// 	id: contextMenuComponent
			// 	ContextMenu {}
			// }
		}
	}
}
