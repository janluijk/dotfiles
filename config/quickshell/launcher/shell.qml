import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import Quickshell.Widgets
import QtQuick

PanelWindow {
    id: root

    // Blacklist file reader
    FileView {
        id: blacklistFile
        path: Qt.resolvedUrl("./blacklist.txt")
        watchChanges: true
    }

    // Usage tracking file
    FileView {
        id: usageFile
        path: Qt.resolvedUrl("./usage.json")
        blockLoading: true
    }

    property var usageData: {
        try {
            let content = usageFile.text() || "{}";
            return JSON.parse(content);
        } catch (e) {
            return {};
        }
    }

    function getUsageCount(appId) {
        return usageData[appId] || 0;
    }

    function recordUsage(appId) {
        let data = usageData;
        data[appId] = (data[appId] || 0) + 1;
        usageFile.setText(JSON.stringify(data, null, 2));
    }

    property var blacklistPatterns: {
        let patterns = [];
        let content = blacklistFile.text() || "";
        let lines = content.split("\n");
        for (let line of lines) {
            line = line.trim();
            if (line && !line.startsWith("#")) {
                patterns.push(line.toLowerCase());
            }
        }
        return patterns;
    }

    function isBlacklisted(appName) {
        let name = appName.toLowerCase();
        for (let pattern of blacklistPatterns) {
            if (name.includes(pattern)) return true;
        }
        return false;
    }
    anchors.top: true
    anchors.bottom: true
    anchors.left: true
    anchors.right: true
    color: "transparent"
    focusable: true

    WlrLayershell.layer: WlrLayer.Overlay
    WlrLayershell.keyboardFocus: WlrKeyboardFocus.Exclusive

    // Click outside to close (on the transparent backdrop)
    MouseArea {
        anchors.fill: parent
        onClicked: Qt.quit()
    }

    // Centered launcher container
    Rectangle {
        id: launcher
        width: 520
        height: Math.min(searchBox.height + resultsContainer.height + 16, 650)
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: parent.height * 0.15
        color: Qt.rgba(0.118, 0.118, 0.180, 0.85)
        radius: 8
        border.color: "#45475A"
        border.width: 1

        // Subtle shadow effect using layered rectangles
        Rectangle {
            anchors.fill: parent
            anchors.margins: -1
            z: -1
            radius: 9
            color: "#000000"
            opacity: 0.3
        }

        Column {
            anchors.fill: parent
            anchors.margins: 8
            spacing: 8

            // Search box
            Rectangle {
                id: searchBox
                width: parent.width
                height: 48
                color: "#11111B"
                radius: 4

                Row {
                    anchors.fill: parent
                    anchors.leftMargin: 12
                    anchors.rightMargin: 12
                    spacing: 12

                    Image {
                        source: Qt.resolvedUrl("./search.svg")
                        width: 22
                        height: 22
                        anchors.verticalCenter: parent.verticalCenter
                    }

                    TextInput {
                        id: searchInput
                        width: parent.width - 40
                        anchors.verticalCenter: parent.verticalCenter
                        color: "#CDD6F4"
                        font.pixelSize: 20
                        font.family: "JetBrains Mono"
                        focus: true
                        clip: true

                        property var filteredApps: {
                            let apps = [];
                            let query = text.toLowerCase();
                            for (let i = 0; i < DesktopEntries.applications.values.length; i++) {
                                let app = DesktopEntries.applications.values[i];
                                if (root.isBlacklisted(app.name)) continue;
                                if (query === "" || app.name.toLowerCase().includes(query)) {
                                    apps.push(app);
                                }
                            }
                            // Sort by usage count (descending)
                            apps.sort((a, b) => root.getUsageCount(b.id) - root.getUsageCount(a.id));
                            return apps.slice(0, 4);
                        }

                        Keys.onEscapePressed: Qt.quit()
                        Keys.onReturnPressed: {
                            if (filteredApps.length > 0) {
                                let app = filteredApps[appList.currentIndex];
                                root.recordUsage(app.id);
                                app.execute();
                                Qt.quit();
                            }
                        }
                        Keys.onDownPressed: {
                            if (appList.currentIndex < filteredApps.length - 1) {
                                appList.currentIndex++;
                            }
                        }
                        Keys.onUpPressed: {
                            if (appList.currentIndex > 0) {
                                appList.currentIndex--;
                            }
                        }
                    }
                }
            }

            // Results container
            Rectangle {
                id: resultsContainer
                width: parent.width
                height: Math.min(appList.contentHeight, 400)
                color: "transparent"
                clip: true

                ListView {
                    id: appList
                    anchors.fill: parent
                    model: searchInput.filteredApps
                    currentIndex: 0
                    spacing: 2

                    delegate: Rectangle {
                        required property var modelData
                        required property int index
                        width: appList.width
                        height: 56
                        color: appList.currentIndex === index ? "#181825" : "transparent"
                        radius: 4

                        // Blue accent bar for selected item
                        Rectangle {
                            visible: appList.currentIndex === index
                            width: 3
                            height: parent.height - 16
                            anchors.left: parent.left
                            anchors.leftMargin: 4
                            anchors.verticalCenter: parent.verticalCenter
                            color: "#89B4FA"
                            radius: 2
                        }

                        Row {
                            anchors.fill: parent
                            anchors.leftMargin: 16
                            spacing: 12

                            IconImage {
                                source: "image://icon/" + modelData.icon
                                width: 36
                                height: 36
                                anchors.verticalCenter: parent.verticalCenter
                            }

                            Column {
                                anchors.verticalCenter: parent.verticalCenter
                                spacing: 2

                                Text {
                                    text: modelData.name
                                    color: "#CDD6F4"
                                    font.pixelSize: 18
                                    font.family: "JetBrains Mono"
                                }

                                Text {
                                    text: modelData.genericName || ""
                                    color: "#6C7086"
                                    font.pixelSize: 13
                                    font.family: "JetBrains Mono"
                                    visible: text !== ""
                                }
                            }
                        }

                        MouseArea {
                            anchors.fill: parent
                            hoverEnabled: true
                            onEntered: appList.currentIndex = index
                            onClicked: {
                                root.recordUsage(modelData.id);
                                modelData.execute();
                                Qt.quit();
                            }
                        }
                    }
                }
            }
        }
    }
}
