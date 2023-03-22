import QtQuick
import QtQuick.Controls.Material
import QtMultimedia

Item {

    property var posicaoBarraDeRolagem: 0.0

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

            ScrollView {
                id: scrollViewTextAreaTeleprompter
                anchors.fill: parent
                ScrollBar.vertical.position: posicaoBarraDeRolagem

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
                }

            }

            /*Flickable {
                id: flick
                z:1
                anchors.horizontalCenter: teleprompterTab.horizontalCenter
                width: parent.width
                height: parent.height
                flickableDirection: Flickable.VerticalFlick

                TextArea.flickable: textAreaTeleprompter

                contentY: 100

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

            }*/

        }



    }
}

