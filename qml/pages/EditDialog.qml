import QtQuick 2.0
import Sailfish.Silica 1.0

Dialog {
	property alias name: nameField.text
	property alias stop: stopField.text
	property alias bus:  busField.text
	property int index

	// canAccept: stopField.acceptableInput

	// onAccepted: {
	// 	console.log(parent);
	// 	console.log(index, name, stop, bus);
	// 	console.log(page);
	// 	console.log(parent.setRow(index, name, stop, bus));
	// }

	SilicaFlickable {
		anchors.fill: parent
		
		Column {
			width: parent.width
			DialogHeader {
				title: qsTr("Edit bus stop")
				acceptText: qsTr("Save")
			}

			SectionHeader { text: qsTr("Customize entry")}
			TextField {
				id: nameField
				width: parent.width
				// text: name
				label: qsTr("Optional name for the entry")
			}

			SectionHeader { text: qsTr("Bus stop details")}
			TextField {
				id: stopField
				width: parent.width
				// text: stop
				inputMethodHints: Qt.ImhDigitsOnly
				label: qsTr("Bus stop number, as seen in the marquee")
				validator: IntValidator {}
			}
			TextField {
				id: busField
				width: parent.width
				// text: bus
				label: qsTr("The bus line number")
				inputMethodHints: Qt.ImhDigitsOnly
				// placeholderText: ""
				// validator: IntValidator {}
			}
		}
	}

}
