pragma Singleton

import Quickshell
import Quickshell.Hyprland
import QtQuick

QtObject {
    id: root

    // Map of screen name -> visibility object
    property var screens: ({})

    function register(screen: ShellScreen, visibilities: QtObject): void {
        screens[screen.name] = visibilities;
        screensChanged();
    }

    function unregister(screen: ShellScreen): void {
        delete screens[screen.name];
        screensChanged();
    }

    function getForScreen(screen: ShellScreen): QtObject {
        return screens[screen.name] ?? null;
    }

    function getForActive(): QtObject {
        const focusedMonitor = Hyprland.focusedMonitor;
        if (focusedMonitor) {
            const screen = Quickshell.screens.find(s => Hyprland.monitorFor(s)?.id === focusedMonitor.id);
            if (screen)
                return screens[screen.name] ?? null;
        }
        // Fallback to first screen
        const firstKey = Object.keys(screens)[0];
        return firstKey ? screens[firstKey] : null;
    }
}
