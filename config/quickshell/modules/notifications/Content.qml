pragma ComponentBehavior: Bound

import Quickshell
import Quickshell.Services.Notifications
import QtQuick
import "../../components" as Components
import "../../config" as Config
import "../../theme" as Theme

Item {
    id: root

    required property QtObject visibilities
    required property Item panels
    readonly property int padding: Config.Appearance.padding.large

    property var notificationList: []
    property int listLength: 0
    readonly property int notifCount: Math.min(listLength, Config.Config.notifications.maxVisible)
    readonly property bool hasNotifications: listLength > 0

    implicitWidth: hasNotifications ? Config.Config.notifications.sizes.width + padding : 0
    implicitHeight: hasNotifications ? list.contentHeight + padding * 2 + Config.Config.border.rounding * 2 : 0

    function removeNotification(notif) {
        root.notificationList = root.notificationList.filter(n => n !== notif);
        root.listLength = root.notificationList.length;
    }

    NotificationServer {
        id: server

        keepOnReload: true
        actionsSupported: true
        bodyMarkupSupported: true
        bodyHyperlinksSupported: true
        imageSupported: true
        persistenceSupported: true

        onNotification: notif => {
            notif.tracked = true;
            let newList = [notif, ...root.notificationList];
            if (newList.length > 20) {
                newList = newList.slice(0, 20);
            }
            root.listLength = newList.length;
            root.notificationList = newList;
        }
    }

    Rectangle {
        id: container

        anchors.fill: parent
        anchors.topMargin: root.padding + Config.Config.border.rounding
        anchors.bottomMargin: root.padding + Config.Config.border.rounding
        anchors.leftMargin: root.padding
        anchors.rightMargin: 0  // No right margin - connects to border
        color: "transparent"
        radius: Config.Appearance.rounding.normal
        clip: true

        ListView {
            id: list

            model: root.notificationList.slice(0, Config.Config.notifications.maxVisible)

            anchors.fill: parent

            orientation: Qt.Vertical
            spacing: Config.Appearance.spacing.smaller
            boundsBehavior: Flickable.StopAtBounds
            interactive: false

            add: Transition {
                ParallelAnimation {
                    Components.Anim {
                        property: "x"
                        from: Config.Config.notifications.sizes.width
                        to: 0
                        duration: Config.Appearance.anim.durations.expressiveDefaultSpatial
                        easing.bezierCurve: Config.Appearance.anim.curves.expressiveDefaultSpatial
                    }
                    Components.Anim {
                        property: "opacity"
                        from: 0
                        to: 1
                        duration: Config.Appearance.anim.durations.normal
                    }
                }
            }

            delegate: Item {
                id: wrapper

                required property Notification modelData
                required property int index

                width: ListView.view.width
                height: notif.implicitHeight

                ListView.onRemove: removeAnim.start()

                SequentialAnimation {
                    id: removeAnim

                    PropertyAction {
                        target: wrapper
                        property: "ListView.delayRemove"
                        value: true
                    }
                    ParallelAnimation {
                        Components.Anim {
                            target: notif
                            property: "x"
                            to: Config.Config.notifications.sizes.width + root.padding
                            duration: Config.Appearance.anim.durations.normal
                            easing.bezierCurve: Config.Appearance.anim.curves.emphasizedAccel
                        }
                        Components.Anim {
                            target: notif
                            property: "opacity"
                            to: 0
                            duration: Config.Appearance.anim.durations.normal
                        }
                    }
                    PropertyAction {
                        target: wrapper
                        property: "ListView.delayRemove"
                        value: false
                    }
                }

                NotificationItem {
                    id: notif

                    width: parent.width
                    notification: wrapper.modelData
                    onDismissed: root.removeNotification(wrapper.modelData)

                    MouseArea {
                        id: swipeArea

                        anchors.fill: parent
                        drag.target: notif
                        drag.axis: Drag.XAxis
                        drag.minimumX: 0
                        drag.maximumX: Config.Config.notifications.sizes.width

                        onReleased: {
                            if (notif.x > Config.Config.notifications.sizes.width * 0.4) {
                                wrapper.modelData.dismiss();
                                root.removeNotification(wrapper.modelData);
                            } else {
                                notif.x = 0;
                            }
                        }
                    }

                    Behavior on x {
                        enabled: !swipeArea.drag.active
                        Components.Anim {
                            duration: Config.Appearance.anim.durations.small
                        }
                    }
                }
            }

            move: Transition {
                Components.Anim {
                    property: "y"
                }
            }

            displaced: Transition {
                Components.Anim {
                    property: "y"
                }
            }
        }
    }

    Behavior on implicitWidth {
        Components.Anim {}
    }

    Behavior on implicitHeight {
        Components.Anim {}
    }
}
