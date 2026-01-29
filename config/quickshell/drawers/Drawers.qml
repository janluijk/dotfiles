pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Wayland
import Quickshell.Hyprland
import QtQuick
import QtQuick.Effects
import "../components" as Components
import "../config" as Config
import "../services" as Services
import "../theme" as Theme
import "../modules/bar" as Bar

Variants {
    model: Quickshell.screens

    Scope {
        id: scope

        required property ShellScreen modelData

        PanelWindow {
            id: win

            readonly property bool hasFullscreen: Services.Hypr.monitorFor(screen)?.activeWorkspace?.toplevels.values.some(t => t.lastIpcObject.fullscreen === 2) ?? false

            onHasFullscreenChanged: {
                visibilities.launcher = false;
            }

            screen: scope.modelData
            color: "transparent"

            WlrLayershell.layer: WlrLayer.Top
            WlrLayershell.exclusionMode: ExclusionMode.Ignore
            WlrLayershell.keyboardFocus: visibilities.launcher ? WlrKeyboardFocus.OnDemand : WlrKeyboardFocus.None

            mask: Region {
                x: bar.implicitWidth
                y: Config.Config.border.thickness
                width: win.width - bar.implicitWidth - Config.Config.border.thickness
                height: win.height - Config.Config.border.thickness * 2
                intersection: Intersection.Xor

                regions: panelRegions.instances
            }

            anchors.top: true
            anchors.bottom: true
            anchors.left: true
            anchors.right: true

            Variants {
                id: panelRegions

                model: panels.children

                Region {
                    required property Item modelData

                    x: modelData.x + bar.implicitWidth
                    y: modelData.y + Config.Config.border.thickness
                    width: modelData.width
                    height: modelData.height
                    intersection: Intersection.Subtract
                }
            }

            HyprlandFocusGrab {
                id: focusGrab

                active: visibilities.launcher && Config.Config.launcher.enabled
                windows: [win]
                onCleared: {
                    visibilities.launcher = false;
                }
            }

            // Shadow and content layer
            Item {
                anchors.fill: parent
                layer.enabled: true
                layer.effect: MultiEffect {
                    shadowEnabled: true
                    blurMax: 20
                    shadowColor: Qt.alpha("#000000", 0.6)
                }

                Border {
                    bar: bar
                }

                Backgrounds {
                    panels: panels
                    bar: bar
                }
            }

            // Visibility state
            QtObject {
                id: visibilities

                property bool bar: true
                property bool launcher: false
                property bool notifications: true

                Component.onCompleted: Services.Visibilities.register(scope.modelData, this)
                Component.onDestruction: Services.Visibilities.unregister(scope.modelData)
            }

            Interactions {
                screen: scope.modelData
                visibilities: visibilities
                panels: panels
                bar: bar

                Panels {
                    id: panels

                    screen: scope.modelData
                    visibilities: visibilities
                    bar: bar
                }

                Bar.BarWrapper {
                    id: bar

                    anchors.top: parent.top
                    anchors.bottom: parent.bottom

                    screen: scope.modelData
                    visibilities: visibilities
                }
            }
        }
    }
}
