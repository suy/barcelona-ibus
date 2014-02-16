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

        experimental.userAgent: "Opera/9.80 (J2ME/MIDP; Opera Mini/9 (Compatible; MSIE:9.0; iPhone; BlackBerry9700; AppleWebKit/24.746; U; en) Presto/2.5.25 Version/10.54"
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
