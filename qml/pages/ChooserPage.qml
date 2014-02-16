import QtQuick 2.0
import Sailfish.Silica 1.0

Page {
    id: page
	property string stopUrl: "http://www.tmb.cat/mobile/pwtmb?action=ibus_parada&parada=%1"
	property string busUrl:  "http://www.tmb.cat/mobile/pwtmb?action=info_parada&parada=%1&busNumber=%2"

	SilicaListView {
		id: stopsList
		anchors.fill: parent
		model: stopsModel

		header: PageHeader { title: qsTr("Configured Stops")}

		ViewPlaceholder {
			enabled: stopsModel.count === 0
			text: qsTr("Add bus stops from the menu")
		}

		delegate: BackgroundItem {
			id: backgroundItem
			width: ListView.view.width
			Label {
				text: qsTr("Stop %1. Bus %2.").arg(stop).arg(bus)
				x: Theme.paddingSmall
				anchors.verticalCenter: parent.verticalCenter
				height: Theme.itemSizeSmall
				width: page.width - 2*Theme.paddingSmall
				font.pixelSize: Theme.fontSizeMedium
				font.bold: current === true
				color: current === true? Theme.secondaryColor: Theme.primaryColor
				truncationMode: TruncationMode.Fade
			}
			onClicked: {
				current=true; // FIXME: doesn't work

				var url;
				if (bus === undefined) {
					url = stopUrl.arg(stop);
				} else {
					url = busUrl.arg(stop).arg(bus);
				}
				webPage.pageUrl = url;
				pageStack.navigateForward(PageStackAction.Animated);
			}

			ListView.onAdd:    AddAnimation    { target: backgroundItem }
			ListView.onRemove: RemoveAnimation { target: backgroundItem }
		}


		ListModel {
			id: stopsModel
			ListElement {
				stop: "1019"
				current: false
			}
			ListElement {
				stop: "1019"
				bus: "60"
				current: false
			}
			ListElement {
				stop: "1019"
				bus: "73"
				current: false
			}
			ListElement {
				stop: "71"
				bus: "60"
				current: false
			}
		}
	}
}
