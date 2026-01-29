pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Services.SystemTray
import QtQuick
import "../../../components" as Components
import "../../../config" as Config
import "../../../theme" as Theme

Item {
    id: root

    required property SystemTrayItem modelData

    implicitWidth: Config.Config.bar.sizes.innerWidth - Config.Appearance.padding.normal * 2
    implicitHeight: implicitWidth

    Image {
        id: icon

        anchors.centerIn: parent
        width: parent.width
        height: parent.height

        source: root.modelData.icon ?? ""
        sourceSize.width: width
        sourceSize.height: height
        fillMode: Image.PreserveAspectFit
        smooth: true
        asynchronous: true
    }

    MouseArea {
        anchors.fill: parent
        acceptedButtons: Qt.LeftButton | Qt.RightButton | Qt.MiddleButton

        onClicked: event => {
            if (event.button === Qt.LeftButton) {
                root.modelData.activate();
            } else if (event.button === Qt.RightButton) {
                root.modelData.menu?.popup();
            } else if (event.button === Qt.MiddleButton) {
                root.modelData.secondaryActivate();
            }
        }

        onWheel: event => {
            if (event.angleDelta.y > 0)
                root.modelData.scroll(1, false);
            else if (event.angleDelta.y < 0)
                root.modelData.scroll(-1, false);
        }
    }
}
