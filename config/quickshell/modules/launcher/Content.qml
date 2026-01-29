pragma ComponentBehavior: Bound

import Quickshell
import QtQuick
import "../../components" as Components
import "../../config" as Config
import "../../theme" as Theme

Item {
    id: root

    required property QtObject visibilities
    required property var panels
    required property real maxHeight

    readonly property int padding: Config.Appearance.padding.large
    readonly property int rounding: Config.Appearance.rounding.large

    implicitWidth: listWrapper.width + padding * 2
    implicitHeight: searchWrapper.height + listWrapper.height + padding * 2

    Item {
        id: listWrapper

        implicitWidth: appList.width
        implicitHeight: appList.height + root.padding * 2

        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: searchWrapper.top
        anchors.bottomMargin: root.padding

        AppList {
            id: appList

            anchors.bottom: parent.bottom
            anchors.bottomMargin: root.padding

            visibilities: root.visibilities
            maxHeight: root.maxHeight - searchWrapper.implicitHeight - root.padding * 4
            search: search
            padding: root.padding
            rounding: root.rounding
        }
    }

    Components.StyledRect {
        id: searchWrapper

        color: Qt.alpha(Theme.Theme.surface1, 0.9)
        radius: Config.Appearance.rounding.full

        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.margins: root.padding

        implicitHeight: Math.max(searchIcon.implicitHeight, search.implicitHeight, clearIcon.implicitHeight)

        Components.MaterialIcon {
            id: searchIcon

            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left
            anchors.leftMargin: root.padding

            text: "search"
            color: Theme.Theme.subtext0
        }

        TextInput {
            id: search

            anchors.left: searchIcon.right
            anchors.right: clearIcon.left
            anchors.verticalCenter: parent.verticalCenter
            anchors.leftMargin: Config.Appearance.spacing.small
            anchors.rightMargin: Config.Appearance.spacing.small

            topPadding: Config.Appearance.padding.larger
            bottomPadding: Config.Appearance.padding.larger

            color: Theme.Theme.text
            selectionColor: Theme.Theme.blue
            selectedTextColor: Theme.Theme.crust
            font.family: Config.Appearance.font.family.sans
            font.pixelSize: Config.Appearance.font.size.normal

            property string placeholderText: "Search applications..."

            Text {
                anchors.fill: parent
                anchors.leftMargin: parent.leftPadding
                verticalAlignment: Text.AlignVCenter
                text: parent.placeholderText
                color: Theme.Theme.overlay0
                font: parent.font
                visible: !parent.text && !parent.activeFocus
            }

            onAccepted: {
                const currentItem = appList.currentItem;
                if (currentItem) {
                    currentItem.modelData.launch();
                    root.visibilities.launcher = false;
                }
            }

            Keys.onUpPressed: appList.decrementCurrentIndex()
            Keys.onDownPressed: appList.incrementCurrentIndex()
            Keys.onEscapePressed: root.visibilities.launcher = false

            Component.onCompleted: forceActiveFocus()

            Connections {
                target: root.visibilities

                function onLauncherChanged(): void {
                    if (!root.visibilities.launcher)
                        search.text = "";
                    else
                        search.forceActiveFocus();
                }
            }
        }

        Components.MaterialIcon {
            id: clearIcon

            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right
            anchors.rightMargin: root.padding

            width: search.text ? implicitWidth : implicitWidth / 2
            opacity: search.text ? 1 : 0

            text: "close"
            color: Theme.Theme.subtext0

            MouseArea {
                anchors.fill: parent
                hoverEnabled: true
                cursorShape: search.text ? Qt.PointingHandCursor : undefined
                onClicked: search.text = ""
            }

            Behavior on width {
                Components.Anim {
                    duration: Config.Appearance.anim.durations.small
                }
            }

            Behavior on opacity {
                Components.Anim {
                    duration: Config.Appearance.anim.durations.small
                }
            }
        }
    }
}
