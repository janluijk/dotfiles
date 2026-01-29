pragma ComponentBehavior: Bound

import Quickshell.Services.SystemTray
import QtQuick
import "../../../components" as Components
import "../../../config" as Config
import "../../../theme" as Theme

Components.StyledRect {
    id: root

    readonly property alias layout: layout
    readonly property alias items: items
    readonly property alias expandIcon: expandIcon

    readonly property int padding: Config.Config.bar.tray.background ? Config.Appearance.padding.normal : Config.Appearance.padding.small
    readonly property int itemSpacing: Config.Config.bar.tray.background ? Config.Appearance.spacing.small : 0

    property bool expanded

    readonly property real nonAnimHeight: {
        if (!Config.Config.bar.tray.compact)
            return layout.implicitHeight + padding * 2;
        return (expanded ? expandIcon.implicitHeight + layout.implicitHeight + itemSpacing : expandIcon.implicitHeight) + padding * 2;
    }

    clip: true
    visible: height > 0

    implicitWidth: Config.Config.bar.sizes.innerWidth
    implicitHeight: nonAnimHeight

    color: Qt.alpha(Theme.Theme.surface0, (Config.Config.bar.tray.background && items.count > 0) ? 0.8 : 0)
    radius: Config.Appearance.rounding.full

    Column {
        id: layout

        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: root.padding
        spacing: Config.Appearance.spacing.small

        opacity: root.expanded || !Config.Config.bar.tray.compact ? 1 : 0

        Repeater {
            id: items

            model: SystemTray.items

            TrayItem {}
        }

        Behavior on opacity {
            Components.Anim {}
        }
    }

    Loader {
        id: expandIcon

        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom

        active: Config.Config.bar.tray.compact

        sourceComponent: Item {
            implicitWidth: expandIconInner.implicitWidth
            implicitHeight: expandIconInner.implicitHeight - Config.Appearance.padding.small * 2

            Components.MaterialIcon {
                id: expandIconInner

                anchors.horizontalCenter: parent.horizontalCenter
                anchors.bottom: parent.bottom
                anchors.bottomMargin: Config.Config.bar.tray.background ? Config.Appearance.padding.small : -Config.Appearance.padding.small
                text: "expand_less"
                font.pixelSize: Config.Appearance.font.size.large
                color: Theme.Theme.subtext0
                rotation: root.expanded ? 180 : 0

                Behavior on rotation {
                    Components.Anim {}
                }
            }
        }
    }

    MouseArea {
        anchors.fill: expandIcon
        visible: Config.Config.bar.tray.compact
        onClicked: root.expanded = !root.expanded
    }

    Behavior on implicitHeight {
        Components.Anim {
            duration: Config.Appearance.anim.durations.expressiveDefaultSpatial
            easing.bezierCurve: Config.Appearance.anim.curves.expressiveDefaultSpatial
        }
    }
}
