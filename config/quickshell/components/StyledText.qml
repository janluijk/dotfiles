import QtQuick
import "../theme" as Theme
import "../config" as Config

Text {
    id: root

    property bool animate: false

    color: Theme.Theme.text
    font.family: Config.Appearance.font.family.sans
    font.pixelSize: Config.Appearance.font.size.normal

    Behavior on color {
        enabled: root.animate
        ColorAnimation {
            duration: Config.Appearance.anim.durations.normal
            easing.type: Easing.BezierSpline
            easing.bezierCurve: Config.Appearance.anim.curves.standard
        }
    }
}
