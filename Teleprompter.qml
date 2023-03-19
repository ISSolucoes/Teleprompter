import QtQuick
import QtQuick.Controls.Material
import QtMultimedia

Item {

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
        anchors.horizontalCenter: root.horizontalCenter

        TextArea {
            id: textArea
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
            text: ""
            width: root.width
            height: root.height * 1/4
            cursorVisible: false
            wrapMode: Text.Wrap
            clip: true
        }

        Flickable {
            id: flick
            z:1
            anchors.top: 10/100
            anchors.horizontalCenter: coluna.horizontalCenter
            width: root.width //- (root.width * 10/100)
            height: root.height * 1/4;
            flickableDirection: Flickable.VerticalFlick

            TextArea.flickable: textArea

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

