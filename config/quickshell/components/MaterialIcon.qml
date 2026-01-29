import QtQuick
import "../theme" as Theme
import "../config" as Config

Text {
    id: root

    property bool animate: false
    property int fill: 0
    property int grade: 0

    color: Theme.Theme.text
    font.family: Config.Appearance.font.family.material
    font.pixelSize: Config.Appearance.font.size.larger

    font.variableAxes: ({
        "FILL": root.fill,
        "GRAD": root.grade
    })

    Behavior on color {
        enabled: root.animate
        ColorAnimation {
            duration: Config.Appearance.anim.durations.normal
            easing.type: Easing.BezierSpline
            easing.bezierCurve: Config.Appearance.anim.curves.standard
        }
    }

    Behavior on font.variableAxes {
        enabled: root.animate
        NumberAnimation {
            duration: Config.Appearance.anim.durations.normal
            easing.type: Easing.BezierSpline
            easing.bezierCurve: Config.Appearance.anim.curves.standard
        }
    }
}
