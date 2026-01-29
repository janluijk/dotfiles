pragma ComponentBehavior: Bound

import Quickshell
import QtQuick
import "../../components" as Components
import "../../config" as Config
import "../../theme" as Theme

ListView {
    id: root

    required property QtObject visibilities
    required property real maxHeight
    required property TextInput search
    required property int padding
    required property int rounding

    readonly property var filteredApps: {
        const searchText = search.text.toLowerCase().trim();
        const apps = DesktopEntries.applications.values;

        if (!searchText)
            return apps.slice(0, Config.Config.launcher.maxShown);

        return apps.filter(app => {
            const name = (app.name || "").toLowerCase();
            const genericName = (app.genericName || "").toLowerCase();
            const comment = (app.comment || "").toLowerCase();
            return name.includes(searchText) || genericName.includes(searchText) || comment.includes(searchText);
        }).slice(0, Config.Config.launcher.maxShown);
    }

    model: filteredApps

    width: Config.Config.launcher.width
    height: Math.min(contentHeight, maxHeight)

    clip: true
    spacing: Config.Appearance.spacing.smaller
    orientation: Qt.Vertical
    boundsBehavior: Flickable.StopAtBounds

    currentIndex: 0

    onFilteredAppsChanged: currentIndex = 0

    delegate: AppItem {
        required property DesktopEntry modelData
        required property int index

        width: root.width
        entry: modelData
        isSelected: root.currentIndex === index

        onClicked: {
            modelData.launch();
            root.visibilities.launcher = false;
        }
    }

    Behavior on height {
        Components.Anim {}
    }
}
