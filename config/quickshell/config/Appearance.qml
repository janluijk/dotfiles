pragma Singleton

import QtQuick

QtObject {
    id: root

    readonly property var rounding: QtObject {
        readonly property real scale: 1
        readonly property int small: Math.round(12 * scale)
        readonly property int normal: Math.round(17 * scale)
        readonly property int large: Math.round(25 * scale)
        readonly property int full: 1000
    }

    readonly property var spacing: QtObject {
        readonly property real scale: 1
        readonly property int small: Math.round(7 * scale)
        readonly property int smaller: Math.round(10 * scale)
        readonly property int normal: Math.round(12 * scale)
        readonly property int larger: Math.round(15 * scale)
        readonly property int large: Math.round(20 * scale)
    }

    readonly property var padding: QtObject {
        readonly property real scale: 1
        readonly property int small: Math.round(5 * scale)
        readonly property int smaller: Math.round(7 * scale)
        readonly property int normal: Math.round(10 * scale)
        readonly property int larger: Math.round(12 * scale)
        readonly property int large: Math.round(15 * scale)
    }

    readonly property var font: QtObject {
        readonly property var family: QtObject {
            readonly property string sans: "Rubik"
            readonly property string mono: "JetBrains Mono"
            readonly property string material: "Material Symbols Rounded"
        }

        readonly property var size: QtObject {
            readonly property real scale: 1
            readonly property int small: Math.round(11 * scale)
            readonly property int smaller: Math.round(12 * scale)
            readonly property int normal: Math.round(13 * scale)
            readonly property int larger: Math.round(15 * scale)
            readonly property int large: Math.round(18 * scale)
            readonly property int extraLarge: Math.round(28 * scale)
        }
    }

    readonly property var anim: QtObject {
        readonly property var curves: QtObject {
            readonly property list<real> emphasized: [0.05, 0, 2 / 15, 0.06, 1 / 6, 0.4, 5 / 24, 0.82, 0.25, 1, 1, 1]
            readonly property list<real> emphasizedAccel: [0.3, 0, 0.8, 0.15, 1, 1]
            readonly property list<real> emphasizedDecel: [0.05, 0.7, 0.1, 1, 1, 1]
            readonly property list<real> standard: [0.2, 0, 0, 1, 1, 1]
            readonly property list<real> standardAccel: [0.3, 0, 1, 1, 1, 1]
            readonly property list<real> standardDecel: [0, 0, 0, 1, 1, 1]
            readonly property list<real> expressiveFastSpatial: [0.42, 1.67, 0.21, 0.9, 1, 1]
            readonly property list<real> expressiveDefaultSpatial: [0.38, 1.21, 0.22, 1, 1, 1]
            readonly property list<real> expressiveEffects: [0.34, 0.8, 0.34, 1, 1, 1]
        }

        readonly property var durations: QtObject {
            readonly property real scale: 1
            readonly property int small: Math.round(200 * scale)
            readonly property int normal: Math.round(400 * scale)
            readonly property int large: Math.round(600 * scale)
            readonly property int extraLarge: Math.round(1000 * scale)
            readonly property int expressiveFastSpatial: Math.round(350 * scale)
            readonly property int expressiveDefaultSpatial: Math.round(500 * scale)
            readonly property int expressiveEffects: Math.round(200 * scale)
        }
    }
}
