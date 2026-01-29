import Quickshell
import QtQuick
import "drawers"
import "services" as Services

ShellRoot {
    id: shell

    Drawers {}

    Shortcuts {
        getVisibilities: () => Services.Visibilities.getForActive()
    }
}
