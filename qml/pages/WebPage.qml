import QtQuick 2.0
import Sailfish.Silica 1.0


Page {
    id: page
    SilicaWebView {
        id: webView

        anchors {
            top: parent.top
            left: parent.left
            right: parent.right
            bottom: urlField.top
        }
        url: "http://tmb.cat/mobile"
    }

    TextField {
        id: urlField
        anchors {
            left: parent.left
            right: parent.right
            bottom: parent.bottom
        }
        inputMethodHints: Qt.ImhUrlCharactersOnly
        text: webView.url
        label: webView.title
        EnterKey.onClicked: {
            webView.url = text
            parent.focus = true
        }
    }
}
