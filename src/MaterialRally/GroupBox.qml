import QtQuick
import QtQuick.Controls as T
import QtQuick.Controls.Material as T
import QtQuick.Layouts
import "helper.js" as Helper

T.GroupBox {

    id: control

    property BusyAction mainAction
    property string infoText: ""
    property alias icon: iconLabel.icon

    T.Material.roundedScale: T.Material.NotRounded

    TapHandler {
        onTapped: {
            control.focus = false
        }
    }

    background: Rectangle {
        width: parent.width
        height: parent.height
        color: "#393942"
        radius: control.T.Material.roundedScale
    }

    topPadding: padding + control.implicitLabelHeight

    clip: true

    Behavior on implicitHeight {
        NumberAnimation {
            duration: 300
            easing.type: Easing.OutCubic
        }
    }

    label: Item {

        z: 1
        x: control.leftPadding
        visible: control.title.length > 0 || control.mainAction
        implicitWidth: visible ? control.availableWidth : 0
        implicitHeight: visible ? control.T.Material.delegateHeight - 4 : 0

        MouseArea {
            anchors.fill: parent
            onClicked: {
                control.focus = false
            }
        }

        RowLayout {

            id: row
            anchors.fill: parent

            Icon {
                id: iconLabel
            }

            Item {

                Layout.fillWidth: true

                T.Label {
                    id: label
                    text: control.title
                    elide: Text.ElideRight
                    anchors.verticalCenter: parent.verticalCenter
                    width: Math.min(
                               implicitWidth,
                               parent.width - (icon.visible ? icon.width : 0) - 6)
                }

                Icon {
                    id: icon
                    visible: control.infoText.length > 0
                    icon.source: "qrc:/icons/material_private/48x48/information-outline.svg"
                    icon.width: 20
                    icon.height: 20
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: label.right
                    anchors.leftMargin: 6

                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            const dialog = Helper.createDialog(
                                             "InfoDialog.qml", control, {
                                                 "text": control.infoText
                                             })
                        }
                    }
                }
            }

            T.ToolButton {
                id: actionButton

                action: control.mainAction
                leftPadding: 0
                rightPadding: 0
                visible: action && !action.checkable
                enabled: control.mainAction ? !control.mainAction.busy : false
                implicitHeight: parent.height

                font.capitalization: Font.AllUppercase
                font.styleName: "Bold"
                font.letterSpacing: 2.8

                background: Rectangle {

                    T.Label {
                        // TextMetrics does not work, retrns wrong width
                        id: text
                        text: actionButton.text
                        font: actionButton.font
                        visible: false
                    }

                    color: actionButton.icon.color
                    anchors.bottom: actionButton.contentItem.bottom
                    anchors.bottomMargin: 5
                    anchors.right: actionButton.contentItem.right

                    width: text.implicitWidth
                    height: actionButton.hovered && actionButton.enabled ? 2 : 0

                    antialiasing: true

                    Behavior on height {
                        enabled: actionButton.enabled
                        SmoothedAnimation {
                            duration: 250
                            velocity: -1
                        }
                    }
                }
            }

            T.Switch {

                id: toggleButton

                Binding {
                    target: control
                    property: "contentHeight"
                    when: toggleButton.visible && !toggleButton.checked
                    value: 0
                }

                Binding {
                    target: control
                    property: "topPadding"
                    when: toggleButton.visible && !toggleButton.checked
                    value: control.implicitLabelHeight
                }

                Binding {
                    target: control
                    property: "bottomPadding"
                    when: toggleButton.visible && !toggleButton.checked
                    value: 0
                }

                Binding {
                    target: control.contentItem
                    property: "opacity"
                    when: toggleButton.visible && !toggleButton.checked
                    value: 0
                }

                action: control.mainAction
                leftPadding: 0
                rightPadding: 0
                checked: true
                visible: action && action.checkable
                enabled: control.mainAction ? !control.mainAction.busy : false
                scale: 0.75
            }
        }

        Rectangle {
            id: devider
            width: control.availableWidth
            color: control.T.Material.backgroundColor
            implicitHeight: 2
            anchors.top: row.bottom

            T.ProgressBar {

                anchors.fill: parent

                visible: control.mainAction ? control.mainAction.busy : false

                indeterminate: true

                Component.onCompleted: {
                    contentItem.implicitHeight = 2
                }
            }
        }
    }
}
