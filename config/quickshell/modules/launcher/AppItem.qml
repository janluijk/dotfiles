pragma ComponentBehavior: Bound

import Quickshell
import QtQuick
import "../../components" as Components
import "../../config" as Config
import "../../theme" as Theme

Components.StyledRect {
    id: root

    required property DesktopEntry entry
    required property bool isSelected

    signal clicked()

    color: isSelected ? Qt.alpha(Theme.Theme.blue, 0.2) : (mouseArea.containsMouse ? Qt.alpha(Theme.Theme.surface1, 0.5) : "transparent")
    radius: Config.Appearance.rounding.normal

    implicitHeight: row.implicitHeight + Config.Appearance.padding.normal * 2

    Row {
        id: row

        anchors.left: parent.left
        anchors.right: parent.right
        anchors.verticalCenter: parent.verticalCenter
        anchors.margins: Config.Appearance.padding.normal

        spacing: Config.Appearance.spacing.normal

        Image {
            id: icon

            width: 36
            height: 36
            anchors.verticalCenter: parent.verticalCenter

            source: root.entry.icon ? Quickshell.iconPath(root.entry.icon, "application-x-executable") : Quickshell.iconPath("application-x-executable")
            sourceSize.width: width
            sourceSize.height: height
            fillMode: Image.PreserveAspectFit
            smooth: true
            asynchronous: true

            // Fallback icon
            Components.MaterialIcon {
                anchors.centerIn: parent
                visible: icon.status !== Image.Ready
                text: "apps"
                color: Theme.Theme.subtext0
                font.pixelSize: 24
            }
        }

        Column {
            anchors.verticalCenter: parent.verticalCenter
            width: parent.width - icon.width - parent.spacing

            Components.StyledText {
                width: parent.width
                text: root.entry.name || "Unknown"
                color: root.isSelected ? Theme.Theme.blue : Theme.Theme.text
                font.pixelSize: Config.Appearance.font.size.normal
                font.bold: root.isSelected
                elide: Text.ElideRight
            }

            Components.StyledText {
                width: parent.width
                text: root.entry.genericName || root.entry.comment || ""
                color: Theme.Theme.subtext0
                font.pixelSize: Config.Appearance.font.size.small
                elide: Text.ElideRight
                visible: text !== ""
            }
        }
    }

    MouseArea {
        id: mouseArea

        anchors.fill: parent
        hoverEnabled: true
        cursorShape: Qt.PointingHandCursor

        onClicked: root.clicked()
    }
}
