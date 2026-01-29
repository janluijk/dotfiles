pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Services.Notifications
import QtQuick
import "../../components" as Components
import "../../config" as Config
import "../../theme" as Theme

Components.StyledRect {
    id: root

    required property Notification notification

    signal dismissed()

    readonly property int padding: Config.Appearance.padding.normal
    readonly property int iconSize: 44

    color: Qt.alpha(Theme.Theme.surface0, 0.95)
    radius: Config.Appearance.rounding.normal

    implicitWidth: Config.Config.notifications.sizes.width
    implicitHeight: content.implicitHeight + padding * 2

    Column {
        id: content

        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.margins: root.padding

        spacing: Config.Appearance.spacing.small

        // Header row with icon and title
        Row {
            width: parent.width
            spacing: Config.Appearance.spacing.normal

            // App icon
            Item {
                width: root.iconSize
                height: root.iconSize

                Image {
                    id: appIcon

                    anchors.fill: parent
                    source: root.notification?.appIcon ? Quickshell.iconPath(root.notification?.appIcon, "dialog-information") : ""
                    sourceSize.width: width
                    sourceSize.height: height
                    fillMode: Image.PreserveAspectFit
                    smooth: true
                    asynchronous: true
                    visible: status === Image.Ready
                }

                Components.MaterialIcon {
                    anchors.centerIn: parent
                    visible: appIcon.status !== Image.Ready
                    text: "notifications"
                    color: Theme.Theme.blue
                    font.pixelSize: 28
                }
            }

            // Title and app name
            Column {
                width: parent.width - root.iconSize - closeBtn.width - parent.spacing * 2
                anchors.verticalCenter: parent.verticalCenter
                spacing: 2

                Components.StyledText {
                    width: parent.width
                    text: root.notification?.summary || "Notification"
                    color: Theme.Theme.text
                    font.pixelSize: Config.Appearance.font.size.normal
                    font.bold: true
                    elide: Text.ElideRight
                }

                Components.StyledText {
                    width: parent.width
                    text: root.notification?.appName ?? ""
                    color: Theme.Theme.subtext0
                    font.pixelSize: Config.Appearance.font.size.small
                    elide: Text.ElideRight
                    visible: text !== ""
                }
            }

            // Close button
            Item {
                id: closeBtn

                width: 28
                height: 28
                anchors.verticalCenter: parent.verticalCenter

                Components.StyledRect {
                    anchors.fill: parent
                    color: closeMouse.containsMouse ? Qt.alpha(Theme.Theme.red, 0.2) : "transparent"
                    radius: Config.Appearance.rounding.small

                    Components.MaterialIcon {
                        anchors.centerIn: parent
                        text: "close"
                        color: closeMouse.containsMouse ? Theme.Theme.red : Theme.Theme.subtext0
                        font.pixelSize: 18

                        Behavior on color {
                            ColorAnimation { duration: 150 }
                        }
                    }
                }

                MouseArea {
                    id: closeMouse

                    anchors.fill: parent
                    hoverEnabled: true
                    cursorShape: Qt.PointingHandCursor
                    onClicked: {
                        root.notification?.dismiss();
                        root.dismissed();
                    }
                }
            }
        }

        // Body text
        Components.StyledText {
            width: parent.width
            text: root.notification?.body ?? ""
            color: Theme.Theme.subtext1
            font.pixelSize: Config.Appearance.font.size.smaller
            wrapMode: Text.Wrap
            maximumLineCount: 5
            elide: Text.ElideRight
            visible: text !== ""
        }

        // Notification image (if present)
        Image {
            id: notifImage

            width: Math.min(parent.width, 200)
            height: width * 0.6
            visible: Boolean(root.notification?.image) && status === Image.Ready

            source: root.notification?.image ?? ""
            fillMode: Image.PreserveAspectCrop
            smooth: true
            asynchronous: true

            layer.enabled: true
            layer.effect: Components.StyledRect {
                radius: Config.Appearance.rounding.small
            }
        }

        // Action buttons
        Row {
            width: parent.width
            spacing: Config.Appearance.spacing.small
            visible: actionRepeater.count > 0

            Repeater {
                id: actionRepeater

                model: root.notification?.actions ?? []

                Components.StyledRect {
                    required property NotificationAction modelData

                    color: actionMouse.containsMouse ? Qt.alpha(Theme.Theme.blue, 0.2) : Qt.alpha(Theme.Theme.surface1, 0.8)
                    radius: Config.Appearance.rounding.small

                    implicitWidth: Math.min(actionText.implicitWidth + Config.Appearance.padding.normal * 2, (content.width - Config.Appearance.spacing.small * (actionRepeater.count - 1)) / actionRepeater.count)
                    implicitHeight: actionText.implicitHeight + Config.Appearance.padding.small * 2

                    Components.StyledText {
                        id: actionText

                        anchors.centerIn: parent
                        width: parent.width - Config.Appearance.padding.normal * 2
                        text: modelData.text
                        color: Theme.Theme.blue
                        font.pixelSize: Config.Appearance.font.size.small
                        elide: Text.ElideRight
                        horizontalAlignment: Text.AlignHCenter
                    }

                    MouseArea {
                        id: actionMouse

                        anchors.fill: parent
                        hoverEnabled: true
                        cursorShape: Qt.PointingHandCursor
                        onClicked: modelData.invoke()
                    }
                }
            }
        }
    }

    // Expire progress bar
    Rectangle {
        id: progressBg

        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.leftMargin: root.padding
        anchors.rightMargin: root.padding
        anchors.bottomMargin: root.padding / 2
        height: 3
        radius: 2
        color: Qt.alpha(Theme.Theme.surface2, 0.5)
        visible: (root.notification?.expireTimeout ?? 0) > 0

        Rectangle {
            id: progressBar

            anchors.left: parent.left
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            radius: 2
            color: Theme.Theme.blue

            Component.onCompleted: {
                if ((root.notification?.expireTimeout ?? 0) > 0) {
                    width = parent.width;
                    progressAnim.start();
                }
            }

            NumberAnimation {
                id: progressAnim

                target: progressBar
                property: "width"
                from: progressBg.width
                to: 0
                duration: Math.max(0, root.notification?.expireTimeout ?? 0)
            }
        }
    }
}
