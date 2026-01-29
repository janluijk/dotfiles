pragma ComponentBehavior: Bound

import QtQuick
import "../../../components" as Components
import "../../../services" as Services
import "../../../config" as Config
import "../../../theme" as Theme

Column {
    id: root

    property color colour: Theme.Theme.lavender

    spacing: Config.Appearance.spacing.small

    Loader {
        anchors.horizontalCenter: parent.horizontalCenter

        active: Config.Config.bar.clock.showIcon
        visible: active

        sourceComponent: Components.MaterialIcon {
            text: "schedule"
            color: root.colour
        }
    }

    Components.StyledText {
        id: text

        anchors.horizontalCenter: parent.horizontalCenter

        horizontalAlignment: Text.AlignHCenter
        text: Services.Time.format(Config.Config.services.useTwelveHourClock ? "hh\nmm\nA" : "hh\nmm")
        font.pixelSize: Config.Appearance.font.size.smaller
        font.family: Config.Appearance.font.family.mono
        color: root.colour
    }
}
