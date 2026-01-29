pragma Singleton

import Quickshell
import QtQuick

QtObject {
    id: root

    readonly property SystemClock clock: SystemClock {
        id: systemClock
        precision: SystemClock.Seconds
    }

    readonly property date date: systemClock.date

    function format(formatString: string): string {
        return Qt.formatDateTime(date, formatString);
    }
}
