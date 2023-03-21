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
        width: parent.width * 90/100
        height: parent.height * 25/100
        color: "transparent"
        border.width: 5
        border.color: "white"
        radius: 10
        anchors.horizontalCenter: parent.horizontalCenter

        TextArea {
            id: textAreaTeleprompter
            anchors.horizontalCenter: parent.horizontalCenter
            activeFocusOnPress: false
            font {
                pixelSize: 25
                underline: false
                italic: true
                bold: true

            }
            horizontalAlignment: TextEdit.AlignHCenter
            /*onPressed: function() {
                textArea.placeholderText = "";
                textArea.horizontalAlignment = TextEdit.AlignJustify;
                textArea.cursorPosition = 0;
            }*/
            //placeholderText: "Digite aqui seu texto"
            //placeholderTextColor: "black"
            text: textoTeleprompterTabPrincipal
            width: parent.width
            height: parent.height
            cursorVisible: false
            wrapMode: Text.Wrap
            clip: true
            color: "white"
            background: Rectangle {
                color: "black"
                opacity: 0.5
                radius: 10
            }
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

