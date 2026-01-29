pragma ComponentBehavior: Bound

import Quickshell
import QtQuick
import "../../components" as Components
import "../../config" as Config

Item {
    id: root

    required property ShellScreen screen
    required property QtObject visibilities
    required property var panels

    readonly property bool shouldBeActive: visibilities.launcher && Config.Config.launcher.enabled
    property int contentHeight

    readonly property real maxHeight: {
        let max = screen.height - Config.Config.border.thickness * 2 - Config.Appearance.spacing.large;
        return max;
    }

    onMaxHeightChanged: timer.start()

    visible: height > 0
    implicitHeight: 0
    implicitWidth: content.implicitWidth

    onShouldBeActiveChanged: {
        if (shouldBeActive) {
            timer.stop();
            hideAnim.stop();
            showAnim.start();
        } else {
            showAnim.stop();
            hideAnim.start();
        }
    }

    SequentialAnimation {
        id: showAnim

        Components.Anim {
            target: root
            property: "implicitHeight"
            to: root.contentHeight
            duration: Config.Appearance.anim.durations.expressiveDefaultSpatial
            easing.bezierCurve: Config.Appearance.anim.curves.expressiveDefaultSpatial
        }
        ScriptAction {
            script: root.implicitHeight = Qt.binding(() => content.implicitHeight)
        }
    }

    SequentialAnimation {
        id: hideAnim

        ScriptAction {
            script: root.implicitHeight = root.implicitHeight
        }
        Components.Anim {
            target: root
            property: "implicitHeight"
            to: 0
            easing.bezierCurve: Config.Appearance.anim.curves.emphasized
        }
    }

    Connections {
        target: Config.Config.launcher

        function onEnabledChanged(): void {
            timer.start();
        }

        function onMaxShownChanged(): void {
            timer.start();
        }
    }

    Timer {
        id: timer

        interval: Config.Appearance.anim.durations.extraLarge
        onRunningChanged: {
            if (running && !root.shouldBeActive) {
                content.visible = false;
                content.active = true;
            } else {
                root.contentHeight = Math.min(root.maxHeight, content.implicitHeight);
                content.active = Qt.binding(() => root.shouldBeActive || root.visible);
                content.visible = true;
                if (showAnim.running) {
                    showAnim.stop();
                    showAnim.start();
                }
            }
        }
    }

    Loader {
        id: content

        anchors.top: parent.top
        anchors.horizontalCenter: parent.horizontalCenter

        visible: false
        active: false
        Component.onCompleted: timer.start()

        sourceComponent: Content {
            visibilities: root.visibilities
            panels: root.panels
            maxHeight: root.maxHeight

            Component.onCompleted: root.contentHeight = implicitHeight
        }
    }
}
