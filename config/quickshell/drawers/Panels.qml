import Quickshell
import QtQuick
import "../config" as Config
import "../modules/launcher" as Launcher
import "../modules/notifications" as Notifications

Item {
    id: root

    required property ShellScreen screen
    required property QtObject visibilities
    required property Item bar

    readonly property alias launcher: launcher
    readonly property alias notifications: notifications

    anchors.fill: parent
    anchors.margins: Config.Config.border.thickness
    anchors.leftMargin: bar.implicitWidth

    Launcher.Wrapper {
        id: launcher

        screen: root.screen
        visibilities: root.visibilities
        panels: root

        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
    }

    Notifications.Wrapper {
        id: notifications

        visibilities: root.visibilities
        panels: root

        anchors.right: parent.right
        y: parent.height * 0.2  // 20% from top = 80% from bottom
    }
}
