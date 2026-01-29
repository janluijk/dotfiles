import QtQuick
import QtQuick.Shapes
import "../config" as Config
import "../theme" as Theme
import "../modules/launcher" as Launcher
import "../modules/notifications" as Notifications

Shape {
    id: root

    required property Panels panels
    required property Item bar

    anchors.fill: parent
    anchors.margins: Config.Config.border.thickness
    anchors.leftMargin: bar.implicitWidth
    preferredRendererType: Shape.CurveRenderer

    Launcher.Background {
        wrapper: root.panels.launcher

        startX: (root.width - wrapper.width) / 2 - rounding
        startY: root.height
    }

    Notifications.Background {
        wrapper: root.panels.notifications

        startX: root.width
        startY: root.panels.notifications.y
    }
}
