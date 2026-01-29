pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Hyprland
import Quickshell.Io
import QtQuick
import "services" as Services

Scope {
    id: root

    required property var getVisibilities

    GlobalShortcut {
        name: "launcher"
        appid: "quickshell"
        description: "Toggle launcher"

        onPressed: {
            const visibilities = root.getVisibilities();
            if (visibilities)
                visibilities.launcher = !visibilities.launcher;
        }
    }

    GlobalShortcut {
        name: "bar"
        appid: "quickshell"
        description: "Toggle bar"

        onPressed: {
            const visibilities = root.getVisibilities();
            if (visibilities)
                visibilities.bar = !visibilities.bar;
        }
    }

    // IPC handler for external control (e.g., from scripts)
    IpcHandler {
        target: "shell"

        function toggleLauncher(): void {
            const visibilities = root.getVisibilities();
            if (visibilities)
                visibilities.launcher = !visibilities.launcher;
        }

        function toggleBar(): void {
            const visibilities = root.getVisibilities();
            if (visibilities)
                visibilities.bar = !visibilities.bar;
        }

        function showLauncher(): void {
            const visibilities = root.getVisibilities();
            if (visibilities)
                visibilities.launcher = true;
        }

        function hideLauncher(): void {
            const visibilities = root.getVisibilities();
            if (visibilities)
                visibilities.launcher = false;
        }
    }
}
