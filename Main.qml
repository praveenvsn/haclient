import QtQuick
import QtQuick.VirtualKeyboard
import QtWebEngine
import QtQuick.Controls
import com.sweethome.devicemanager

Window {
    id: window
    width: 800
    height: 480
    visible: true
    title: qsTr("Home Assistant")
    flags: Qt.FramelessWindowHint

    function reboot()
    {
        DeviceManager.reboot()
    }

    function powerOff()
    {
        DeviceManager.powerOff()
    }



    Rectangle {
        id: controlBar
        anchors {
            top: parent.top
            left: parent.left
            right: parent.right
        }
        height: parent.height / 20
        color: "black"

        ToolButton {
            id: rebootButton
            ///text:"Reboot"
            icon.source: "assets/reset-button.png"
            onClicked: window.reboot()
            anchors {
                right: shutdownButton.left
                top: parent.top
                bottom: parent.bottom
            }

        }

        ToolButton {
            id: shutdownButton
            ///text:"Shutdown"
            icon.source: "assets/power-button.png"
            onClicked: window.powerOff()
            anchors {
                right: parent.right
                top: parent.top
                bottom: parent.bottom
            }
            height: parent.height * .5
        }

    }


    WebEngineView {
        onLoadingChanged: {
            zoomFactor = 0.60
        }
        anchors {
            top: controlBar.bottom
            left: parent.left
            right: parent.right
            bottom: parent.bottom
        }

        url: "http://homeassistant.local:8123"
    }

    InputPanel {
        id: inputPanel
        z: 99
        x: 0
        y: window.height
        width: window.width

        states: State {
            name: "visible"
            when: inputPanel.active
            PropertyChanges {
                target: inputPanel
                y: window.height - inputPanel.height
            }
        }
        transitions: Transition {
            from: ""
            to: "visible"
            reversible: true
            ParallelAnimation {
                NumberAnimation {
                    properties: "y"
                    duration: 250
                    easing.type: Easing.InOutQuad
                }
            }
        }
    }
}
