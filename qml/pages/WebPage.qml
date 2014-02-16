import QtQuick 2.0
import Sailfish.Silica 1.0


Page {
    id: page
    property alias pageUrl: webView.url
    SilicaWebView {
        id: webView
        anchors.fill: parent
        url: "http://tmb.cat/mobile"

        experimental.userAgent: "Opera/9.80 (J2ME/MIDP; Opera Mini/9 (Compatible; MSIE:9.0; iPhone; BlackBerry9700; AppleWebKit/24.746; U; en) Presto/2.5.25 Version/10.54"
        // For this page, a super sized font is OK. Default are 16 and 0.
        experimental.preferences.defaultFontSize: 24
        experimental.preferences.minimumFontSize: 22

        ProgressCircle {
            value: webView.loadProgress / 100
            anchors.centerIn: parent
            visible: webView.loading
        }

        // TODO: Can the duplication be avoided?
        PullDownMenu {
            MenuItem {
                text: qsTr("Reload")
                onClicked: webView.reload()
            }
        }
        PushUpMenu {
            MenuItem {
                text: qsTr("Reload")
                onClicked: webView.reload()
            }
        }
    }

    // Note: the anchors.bottom of the web view was set to urlField.top
    // TextField {
    //     id: urlField
    //     anchors {
    //         left: parent.left
    //         right: parent.right
    //         bottom: parent.bottom
    //     }
    //     inputMethodHints: Qt.ImhUrlCharactersOnly
    //     text: webView.url
    //     label: webView.title
    //     EnterKey.onClicked: {
    //         webView.url = text
    //         parent.focus = true
    //     }
    // }
}
