import QtQuick
import QtQuick.Controls.Material
import QtMultimedia

Item {

    antialiasing: true

    MediaDevices {
        id: mediaDevices
    }

    VideoOutput {
        id: videoOutput
        anchors.fill: parent
        fillMode: VideoOutput.Stretch
    }

    CaptureSession {
        id: captureSession
        videoOutput: videoOutput
        camera: Camera {
            id: camera
            focusMode: Camera.FocusModeAutoNear
            cameraDevice: mediaDevices.videoInputs[1]
        }
    }


    Rectangle {
        id: retanguloTexto
        width: parent.width * 95/100
        height: parent.height * 25/100
        color: "transparent"
        border.width: 10
        border.color: "#2196F3"
        radius: 10
        anchors.horizontalCenter: parent.horizontalCenter

        Drag.active: dragArea.drag.active

        MouseArea {
            id: dragArea
            anchors.fill: parent
            drag.target: parent
            onPressed: function() {
                retanguloTexto.border.color = "#FFC107";
            }
            onReleased: function() {
                retanguloTexto.border.color = "#2196F3";
            }
        }

        Rectangle {
            id: rectTextoInternoRetanguloTexto
            width: parent.width * 90/100
            height: parent.height * 90/100
            anchors.centerIn: parent
            color: "transparent"

            TextArea {
                id: textAreaTeleprompter
                readOnly: true
                anchors.horizontalCenter: parent.horizontalCenter
                activeFocusOnPress: false
                font {
                    pixelSize: 25
                    underline: false
                    italic: true
                    bold: true
                }
                horizontalAlignment: TextEdit.AlignHCenter
                text: textoTeleprompterTabPrincipal
                width: parent.width
                height: parent.height
                cursorVisible: false
                wrapMode: Text.Wrap
                clip: true
                color: "white"
                /*background: Rectangle {
                    color: "black"
                    opacity: 0.5
                    radius: 10
                }*/
            }

            Flickable {
                id: flick
                z:1
                anchors.horizontalCenter: teleprompterTab.horizontalCenter
                width: parent.width
                height: parent.height
                flickableDirection: Flickable.VerticalFlick

                TextArea.flickable: textAreaTeleprompter

                ScrollBar.vertical: ScrollBar {
                    anchors {
                        topMargin: 3
                        bottomMargin: 3
                    }

                    contentItem: Rectangle {
                        radius: 10
                        color: "black"
                        opacity: 0.4
                    }
                }

            }

        }



    }
}

