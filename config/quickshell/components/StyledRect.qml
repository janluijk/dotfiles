import QtQuick
import "../config" as Config

Rectangle {
    id: root

    color: "transparent"

    Behavior on color {
        ColorAnimation {
            duration: Config.Appearance.anim.durations.normal
            easing.type: Easing.BezierSpline
            easing.bezierCurve: Config.Appearance.anim.curves.standard
        }
    }
}
