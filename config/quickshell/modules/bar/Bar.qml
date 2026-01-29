pragma ComponentBehavior: Bound

import Quickshell
import QtQuick
import QtQuick.Layouts
import "components"
import "../../services" as Services
import "../../config" as Config

ColumnLayout {
    id: root

    required property ShellScreen screen
    required property QtObject visibilities
    readonly property int vPadding: Config.Appearance.padding.large

    function handleWheel(y: real, angleDelta: point): void {
        const ch = childAt(width / 2, y);
        if (ch && ch.id === "workspaces" && Config.Config.bar.scrollActions.workspaces) {
            // Workspace scroll
            const mon = Config.Config.bar.workspaces.perMonitorWorkspaces ? Services.Hypr.monitorFor(screen) : Services.Hypr.focusedMonitor;
            const specialWs = mon?.lastIpcObject?.specialWorkspace?.name;
            if (specialWs?.length > 0)
                Services.Hypr.dispatch(`togglespecialworkspace ${specialWs.slice(8)}`);
            else if (angleDelta.y < 0 || (Config.Config.bar.workspaces.perMonitorWorkspaces ? mon?.activeWorkspace?.id : Services.Hypr.activeWsId) > 1)
                Services.Hypr.dispatch(`workspace r${angleDelta.y > 0 ? "-" : "+"}1`);
        } else if (y < screen.height / 2 && Config.Config.bar.scrollActions.volume) {
            // Volume scroll on top half
            if (angleDelta.y > 0)
                Services.Audio.incrementVolume();
            else if (angleDelta.y < 0)
                Services.Audio.decrementVolume();
        } else if (Config.Config.bar.scrollActions.brightness) {
            // Brightness scroll on bottom half
            const monitor = Services.Brightness.getMonitorForScreen(screen);
            if (angleDelta.y > 0)
                monitor?.setBrightness(monitor.brightness + Config.Config.services.brightnessIncrement);
            else if (angleDelta.y < 0)
                monitor?.setBrightness(monitor.brightness - Config.Config.services.brightnessIncrement);
        }
    }

    spacing: Config.Appearance.spacing.normal

    Repeater {
        id: repeater

        model: Config.Config.bar.entries

        DelegateChooser {
            role: "id"

            DelegateChoice {
                roleValue: "spacer"
                delegate: WrappedLoader {
                    Layout.fillHeight: enabled
                }
            }
            DelegateChoice {
                roleValue: "workspaces"
                delegate: WrappedLoader {
                    sourceComponent: Workspaces {
                        screen: root.screen
                    }
                }
            }
            DelegateChoice {
                roleValue: "tray"
                delegate: WrappedLoader {
                    sourceComponent: Tray {}
                }
            }
            DelegateChoice {
                roleValue: "clock"
                delegate: WrappedLoader {
                    sourceComponent: Clock {}
                }
            }
            DelegateChoice {
                roleValue: "statusIcons"
                delegate: WrappedLoader {
                    sourceComponent: StatusIcons {}
                }
            }
        }
    }

    component WrappedLoader: Loader {
        required property bool enabled
        required property string id
        required property int index

        function findFirstEnabled(): Item {
            const count = repeater.count;
            for (let i = 0; i < count; i++) {
                const item = repeater.itemAt(i);
                if (item?.enabled)
                    return item;
            }
            return null;
        }

        function findLastEnabled(): Item {
            for (let i = repeater.count - 1; i >= 0; i--) {
                const item = repeater.itemAt(i);
                if (item?.enabled)
                    return item;
            }
            return null;
        }

        Layout.alignment: Qt.AlignHCenter

        // Add padding to first and last enabled components
        Layout.topMargin: findFirstEnabled() === this ? root.vPadding : 0
        Layout.bottomMargin: findLastEnabled() === this ? root.vPadding : 0

        visible: enabled
        active: enabled
    }
}
