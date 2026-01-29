pragma ComponentBehavior: Bound

import Quickshell
import QtQuick
import QtQuick.Layouts
import "../../../components" as Components
import "../../../services" as Services
import "../../../config" as Config
import "../../../theme" as Theme

Components.StyledRect {
    id: root

    required property ShellScreen screen

    readonly property bool onSpecial: (Config.Config.bar.workspaces.perMonitorWorkspaces ? Services.Hypr.monitorFor(screen) : Services.Hypr.focusedMonitor)?.lastIpcObject?.specialWorkspace?.name !== ""
    readonly property int activeWsId: Config.Config.bar.workspaces.perMonitorWorkspaces ? (Services.Hypr.monitorFor(screen)?.activeWorkspace?.id ?? 1) : Services.Hypr.activeWsId

    readonly property var occupied: Services.Hypr.workspaces.values.reduce((acc, curr) => {
        acc[curr.id] = curr.lastIpcObject.windows > 0;
        return acc;
    }, {})

    implicitWidth: Config.Config.bar.sizes.innerWidth
    implicitHeight: layout.implicitHeight + Config.Appearance.padding.small * 2

    color: Qt.alpha(Theme.Theme.surface0, 0.8)
    radius: Config.Appearance.rounding.full

    ColumnLayout {
        id: layout

        anchors.centerIn: parent
        spacing: Math.floor(Config.Appearance.spacing.small / 2)

        Repeater {
            id: workspaces

            model: Config.Config.bar.workspaces.shown

            Workspace {
                required property int index

                ws: index + 1
                activeWsId: root.activeWsId
                isOccupied: root.occupied[ws] ?? false
            }
        }
    }

    MouseArea {
        anchors.fill: layout
        onClicked: event => {
            const item = layout.childAt(event.x, event.y);
            if (item && item.ws !== undefined) {
                if (Services.Hypr.activeWsId !== item.ws)
                    Services.Hypr.dispatch(`workspace ${item.ws}`);
                else
                    Services.Hypr.dispatch("togglespecialworkspace special");
            }
        }
    }

    component Workspace: Item {
        id: wsItem

        required property int ws
        required property int activeWsId
        required property bool isOccupied

        readonly property bool isActive: activeWsId === ws

        Layout.alignment: Qt.AlignHCenter
        Layout.preferredHeight: Config.Config.bar.sizes.innerWidth - Config.Appearance.padding.small * 2

        implicitWidth: parent.width
        implicitHeight: Layout.preferredHeight

        Components.StyledText {
            anchors.centerIn: parent

            animate: true
            text: wsItem.ws.toString()
            color: wsItem.isActive ? Theme.Theme.blue : (wsItem.isOccupied ? Theme.Theme.text : Theme.Theme.overlay0)
            font.bold: wsItem.isActive
            font.pixelSize: Config.Appearance.font.size.normal
        }
    }
}
