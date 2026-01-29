pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Services.UPower
import QtQuick
import QtQuick.Layouts
import "../../../components" as Components
import "../../../services" as Services
import "../../../config" as Config
import "../../../theme" as Theme

Components.StyledRect {
    id: root

    property color colour: Theme.Theme.green
    readonly property alias items: iconColumn

    color: Qt.alpha(Theme.Theme.surface0, 0.8)
    radius: Config.Appearance.rounding.full

    clip: true
    implicitWidth: Config.Config.bar.sizes.innerWidth
    implicitHeight: iconColumn.implicitHeight + Config.Appearance.padding.normal * 2

    ColumnLayout {
        id: iconColumn

        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        anchors.bottomMargin: Config.Appearance.padding.normal

        spacing: Config.Appearance.spacing.smaller / 2

        // Audio icon
        WrappedLoader {
            name: "audio"
            active: Config.Config.bar.status.showAudio

            sourceComponent: Components.MaterialIcon {
                animate: true
                text: getVolumeIcon(Services.Audio.volume, Services.Audio.muted)
                color: root.colour

                function getVolumeIcon(volume: real, muted: bool): string {
                    if (muted || volume === 0)
                        return "volume_off";
                    if (volume < 0.33)
                        return "volume_mute";
                    if (volume < 0.66)
                        return "volume_down";
                    return "volume_up";
                }
            }
        }

        // Battery icon
        WrappedLoader {
            name: "battery"
            active: Config.Config.bar.status.showBattery && UPower.displayDevice?.isLaptopBattery

            sourceComponent: Components.MaterialIcon {
                animate: true
                text: getBatteryIcon(UPower.displayDevice?.percentage ?? 0, UPower.displayDevice?.state ?? UPowerDeviceState.Unknown)
                color: !UPower.onBattery || (UPower.displayDevice?.percentage ?? 1) > 0.2 ? root.colour : Theme.Theme.red
                fill: 1

                function getBatteryIcon(perc: real, state: int): string {
                    const charging = [UPowerDeviceState.Charging, UPowerDeviceState.FullyCharged, UPowerDeviceState.PendingCharge].includes(state);
                    if (perc >= 0.95)
                        return charging ? "battery_charging_full" : "battery_full";
                    if (perc >= 0.80)
                        return charging ? "battery_charging_90" : "battery_6_bar";
                    if (perc >= 0.60)
                        return charging ? "battery_charging_80" : "battery_5_bar";
                    if (perc >= 0.40)
                        return charging ? "battery_charging_60" : "battery_4_bar";
                    if (perc >= 0.25)
                        return charging ? "battery_charging_50" : "battery_3_bar";
                    if (perc >= 0.10)
                        return charging ? "battery_charging_30" : "battery_2_bar";
                    return charging ? "battery_charging_20" : "battery_1_bar";
                }
            }
        }
    }

    component WrappedLoader: Loader {
        required property string name

        Layout.alignment: Qt.AlignHCenter
        visible: active
    }
}
