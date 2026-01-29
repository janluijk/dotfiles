pragma ComponentBehavior: Bound

import Quickshell
import QtQuick
import "../../components" as Components
import "../../config" as Config

Item {
    id: root

    required property ShellScreen screen
    required property QtObject visibilities

    readonly property int padding: Math.max(Config.Appearance.padding.smaller, Config.Config.border.thickness)
    readonly property int contentWidth: Config.Config.bar.sizes.innerWidth + padding * 2
    readonly property int exclusiveZone: Config.Config.bar.persistent || visibilities.bar ? contentWidth : Config.Config.border.thickness
    readonly property bool shouldBeVisible: Config.Config.bar.persistent || visibilities.bar || isHovered
    property bool isHovered

    function handleWheel(y: real, angleDelta: point): void {
        content.item?.handleWheel(y, angleDelta);
    }

    visible: width > Config.Config.border.thickness
    implicitWidth: Config.Config.border.thickness

    states: State {
        name: "visible"
        when: root.shouldBeVisible

        PropertyChanges {
            root.implicitWidth: root.contentWidth
        }
    }

    transitions: [
        Transition {
            from: ""
            to: "visible"

            Components.Anim {
                target: root
                property: "implicitWidth"
                duration: Config.Appearance.anim.durations.expressiveDefaultSpatial
                easing.bezierCurve: Config.Appearance.anim.curves.expressiveDefaultSpatial
            }
        },
        Transition {
            from: "visible"
            to: ""

            Components.Anim {
                target: root
                property: "implicitWidth"
                easing.bezierCurve: Config.Appearance.anim.curves.emphasized
            }
        }
    ]

    Loader {
        id: content

        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.right: parent.right

        active: root.shouldBeVisible || root.visible

        sourceComponent: Bar {
            width: root.contentWidth
            screen: root.screen
            visibilities: root.visibilities
        }
    }
}
