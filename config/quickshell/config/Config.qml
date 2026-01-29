pragma Singleton

import Quickshell
import Quickshell.Io
import QtQuick

QtObject {
    id: root

    // Border configuration
    readonly property var border: QtObject {
        readonly property int thickness: 8
        readonly property int rounding: 16
        readonly property color color: "#11111B"
    }

    // Bar configuration
    readonly property var bar: QtObject {
        readonly property bool enabled: true
        readonly property bool persistent: true
        readonly property bool showOnHover: false
        readonly property int dragThreshold: 50

        readonly property var sizes: QtObject {
            readonly property int innerWidth: 44
        }

        readonly property var workspaces: QtObject {
            readonly property int shown: 5
            readonly property bool perMonitorWorkspaces: false
        }

        readonly property var clock: QtObject {
            readonly property bool showIcon: true
        }

        readonly property var tray: QtObject {
            readonly property bool compact: true
            readonly property bool background: true
        }

        readonly property var status: QtObject {
            readonly property bool showAudio: true
            readonly property bool showBattery: true
            readonly property bool showNetwork: false
            readonly property bool showBluetooth: false
        }

        readonly property var scrollActions: QtObject {
            readonly property bool workspaces: true
            readonly property bool volume: true
            readonly property bool brightness: true
        }

        readonly property list<var> entries: [
            { id: "workspaces", enabled: true },
            { id: "spacer", enabled: true },
            { id: "tray", enabled: true },
            { id: "clock", enabled: true },
            { id: "statusIcons", enabled: true }
        ]
    }

    // Launcher configuration
    readonly property var launcher: QtObject {
        readonly property bool enabled: true
        readonly property bool showOnHover: false
        readonly property int dragThreshold: 50
        readonly property int maxShown: 4
        readonly property int width: 400
    }

    // Notifications configuration
    readonly property var notifications: QtObject {
        readonly property bool enabled: true
        readonly property int maxVisible: 5

        readonly property var sizes: QtObject {
            readonly property int width: 320
        }
    }

    // Services configuration
    readonly property var services: QtObject {
        readonly property real audioIncrement: 0.05
        readonly property real brightnessIncrement: 0.05
        readonly property real maxVolume: 1.5
        readonly property bool useTwelveHourClock: false
    }
}
