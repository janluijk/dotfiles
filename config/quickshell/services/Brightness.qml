pragma Singleton
pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Io
import QtQuick
import "../config" as Config

QtObject {
    id: root

    readonly property list<var> monitors: variants.instances

    function getMonitorForScreen(screen: ShellScreen): var {
        return monitors.find(m => m.modelData === screen);
    }

    function getActiveMonitor(): var {
        return monitors.find(m => m.modelData === Quickshell.screens[0]);
    }

    function increaseBrightness(): void {
        const monitor = getActiveMonitor();
        if (monitor)
            monitor.setBrightness(monitor.brightness + Config.Config.services.brightnessIncrement);
    }

    function decreaseBrightness(): void {
        const monitor = getActiveMonitor();
        if (monitor)
            monitor.setBrightness(monitor.brightness - Config.Config.services.brightnessIncrement);
    }

    readonly property Variants variants: Variants {
        id: variants

        model: Quickshell.screens

        QtObject {
            id: monitor

            required property ShellScreen modelData
            property real brightness: 1.0

            readonly property Process initProc: Process {
                stdout: StdioCollector {
                    onStreamFinished: {
                        const parts = text.trim().split(" ");
                        if (parts.length >= 2) {
                            const cur = parseInt(parts[parts.length - 2]) || 0;
                            const max = parseInt(parts[parts.length - 1]) || 100;
                            monitor.brightness = cur / max;
                        }
                    }
                }
            }

            function setBrightness(value: real): void {
                value = Math.max(0, Math.min(1, value));
                const rounded = Math.round(value * 100);
                if (Math.round(brightness * 100) === rounded)
                    return;

                brightness = value;
                Quickshell.execDetached(["brightnessctl", "s", `${rounded}%`]);
            }

            function initBrightness(): void {
                initProc.command = ["sh", "-c", "echo $(brightnessctl g) $(brightnessctl m)"];
                initProc.running = true;
            }

            Component.onCompleted: initBrightness()
        }
    }
}
