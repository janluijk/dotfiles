import QtQuick
import QtQuick.Shapes
import "../../config" as Config
import "../../theme" as Theme

ShapePath {
    id: root

    required property Wrapper wrapper
    readonly property real rounding: Config.Config.border.rounding
    readonly property bool flatten: wrapper.height < rounding * 2
    readonly property real roundingY: flatten ? wrapper.height / 2 : rounding

    strokeWidth: wrapper.visible ? 1 : 0
    strokeColor: wrapper.visible ? Theme.Theme.surface1 : "transparent"
    fillColor: wrapper.visible ? Config.Config.border.color : "transparent"

    // Start at top-right corner, draw the panel extending from the right edge
    // With rounded corners where it meets the border

    // Top-right corner: arc inward from border
    PathArc {
        relativeX: -root.rounding
        relativeY: root.roundingY
        radiusX: root.rounding
        radiusY: root.roundingY
        direction: PathArc.Clockwise
    }
    // Top edge going left
    PathLine {
        relativeX: -(root.wrapper.width - root.rounding * 2)
        relativeY: 0
    }
    // Top-left corner
    PathArc {
        relativeX: -root.rounding
        relativeY: root.roundingY
        radiusX: root.rounding
        radiusY: root.roundingY
        direction: PathArc.Counterclockwise
    }
    // Left edge going down
    PathLine {
        relativeX: 0
        relativeY: root.wrapper.height - root.roundingY * 4
    }
    // Bottom-left corner
    PathArc {
        relativeX: root.rounding
        relativeY: root.roundingY
        radiusX: root.rounding
        radiusY: root.roundingY
        direction: PathArc.Counterclockwise
    }
    // Bottom edge going right
    PathLine {
        relativeX: root.wrapper.width - root.rounding * 2
        relativeY: 0
    }
    // Bottom-right corner: arc outward to border
    PathArc {
        relativeX: root.rounding
        relativeY: root.roundingY
        radiusX: root.rounding
        radiusY: root.roundingY
        direction: PathArc.Clockwise
    }
}
