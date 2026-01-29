import QtQuick
import "../../components" as Components
import "../../config" as Config

Item {
    id: root

    required property QtObject visibilities
    required property Item panels

    visible: width > 0 && height > 0
    implicitWidth: content.implicitWidth
    implicitHeight: content.implicitHeight
    width: implicitWidth
    height: implicitHeight

    Content {
        id: content

        visibilities: root.visibilities
        panels: root.panels

        width: implicitWidth
        height: implicitHeight
    }
}
