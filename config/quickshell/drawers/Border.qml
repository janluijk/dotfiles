pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Effects
import "../components" as Components
import "../config" as Config
import "../theme" as Theme

Item {
    id: root

    required property Item bar

    anchors.fill: parent

    // Solid border rectangle with mask inversion
    Components.StyledRect {
        anchors.fill: parent
        color: Config.Config.border.color

        layer.enabled: true
        layer.effect: MultiEffect {
            maskSource: mask
            maskEnabled: true
            maskInverted: true
            maskThresholdMin: 0.5
            maskSpreadAtMin: 1
        }
    }

    // Mask for the inner cutout (desktop area)
    Item {
        id: mask

        anchors.fill: parent
        layer.enabled: true
        visible: false

        Rectangle {
            anchors.fill: parent
            anchors.margins: Config.Config.border.thickness
            anchors.leftMargin: root.bar.implicitWidth
            radius: Config.Config.border.rounding
        }
    }

    // Inner highlight border
    Rectangle {
        anchors.fill: parent
        anchors.margins: Config.Config.border.thickness
        anchors.leftMargin: root.bar.implicitWidth
        color: "transparent"
        radius: Config.Config.border.rounding
        border.color: Theme.Theme.surface1
        border.width: 1
    }
}
