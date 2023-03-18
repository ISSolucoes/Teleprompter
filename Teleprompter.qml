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
            text: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."
            width: root.width
            height: root.height * 1/4
            cursorVisible: false
            wrapMode: Text.Wrap
            clip: true
        }

        Flickable {
            id: flick
            z:1
            //anchors.top: 10/100
            //anchors.horizontalCenter: coluna.horizontalCenter
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

