pragma Singleton
import QtQuick

QtObject {
    // Base colors
    readonly property color base: "#1E1E2E"
    readonly property color mantle: "#181825"
    readonly property color crust: "#11111B"

    // Surface colors
    readonly property color surface0: "#313244"
    readonly property color surface1: "#45475A"
    readonly property color surface2: "#585B70"

    // Text colors
    readonly property color text: "#CDD6F4"
    readonly property color subtext0: "#A6ADC8"
    readonly property color subtext1: "#BAC2DE"
    readonly property color overlay0: "#6C7086"

    // Accent colors
    readonly property color blue: "#89B4FA"
    readonly property color lavender: "#B4BEFE"
    readonly property color sapphire: "#74C7EC"
    readonly property color green: "#A6E3A1"
    readonly property color red: "#F38BA8"
    readonly property color yellow: "#F9E2AF"
    readonly property color peach: "#FAB387"
    readonly property color rosewater: "#F5E0DC"

    // Border color (crust - almost black)
    readonly property color borderColor: "#11111B"

    // Dimensions
    readonly property int borderWidth: 4
    readonly property int statusBarHeight: 36
    readonly property int shadowSize: 10
    readonly property int radius: 8
    readonly property int popoutWidth: 320

    // Typography
    readonly property string fontFamily: "JetBrains Mono"
    readonly property int fontSizeSmall: 12
    readonly property int fontSizeNormal: 14
    readonly property int fontSizeLarge: 18
}
