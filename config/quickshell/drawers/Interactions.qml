import Quickshell
import QtQuick
import "../config" as Config
import "../services" as Services

MouseArea {
    id: root

    required property ShellScreen screen
    required property QtObject visibilities
    required property Panels panels
    required property Item bar

    property point dragStart

    function withinPanelHeight(panel: Item, x: real, y: real): bool {
        const panelY = Config.Config.border.thickness + panel.y;
        return y >= panelY - Config.Config.border.rounding && y <= panelY + panel.height + Config.Config.border.rounding;
    }

    function withinPanelWidth(panel: Item, x: real, y: real): bool {
        const panelX = bar.implicitWidth + panel.x;
        return x >= panelX - Config.Config.border.rounding && x <= panelX + panel.width + Config.Config.border.rounding;
    }

    function inBottomPanel(panel: Item, x: real, y: real): bool {
        return y > root.height - Config.Config.border.thickness - panel.height - Config.Config.border.rounding && withinPanelWidth(panel, x, y);
    }

    function inRightPanel(panel: Item, x: real, y: real): bool {
        return x > bar.implicitWidth + panel.x && withinPanelHeight(panel, x, y);
    }

    anchors.fill: parent
    hoverEnabled: true

    onPressed: event => dragStart = Qt.point(event.x, event.y)

    onContainsMouseChanged: {
        if (!containsMouse) {
            if (Config.Config.bar.showOnHover)
                bar.isHovered = false;
        }
    }

    onPositionChanged: event => {
        const x = event.x;
        const y = event.y;
        const dragX = x - dragStart.x;
        const dragY = y - dragStart.y;

        // Show bar in non-exclusive mode on hover
        if (!visibilities.bar && Config.Config.bar.showOnHover && x < bar.implicitWidth)
            bar.isHovered = true;

        // Show/hide bar on drag
        if (pressed && dragStart.x < bar.implicitWidth) {
            if (dragX > Config.Config.bar.dragThreshold)
                visibilities.bar = true;
            else if (dragX < -Config.Config.bar.dragThreshold)
                visibilities.bar = false;
        }

        // Show launcher on hover or drag
        if (Config.Config.launcher.showOnHover) {
            if (!visibilities.launcher && inBottomPanel(panels.launcher, x, y))
                visibilities.launcher = true;
        } else if (pressed && inBottomPanel(panels.launcher, dragStart.x, dragStart.y) && withinPanelWidth(panels.launcher, x, y)) {
            if (dragY < -Config.Config.launcher.dragThreshold)
                visibilities.launcher = true;
            else if (dragY > Config.Config.launcher.dragThreshold)
                visibilities.launcher = false;
        }
    }

    onWheel: event => {
        if (event.x < bar.implicitWidth) {
            bar.handleWheel(event.y, event.angleDelta);
        }
    }
}
