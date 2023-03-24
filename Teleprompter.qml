import QtQuick
import QtQuick.Controls.Material
import QtMultimedia
import QtQuick.Layouts

Item {

    property real posicaoBarraDeRolagem: 0.0
    property int cameraEscolhida: 1

    antialiasing: true

    // ----------------------------------------  VIDEO Components -----------------------------------------
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
            cameraDevice: mediaDevices.videoInputs[cameraEscolhida]
        }
        audioInput: AudioInput {
            id: audioInputVideo
            volume: 1
        }
        recorder: MediaRecorder {
            id: mediaRecorder
            quality: MediaRecorder.VeryLowQuality
            onActualLocationChanged: function(url) {
                console.log("actualLocation: " + url);
            }
            outputLocation: "file:///storage/emulated/0/DCIM/Camera"
            onErrorOccurred: function(error) {
                console.log("Error ocurred: " + error);
            }
        }
    }
    // ----------------------------------------  VIDEO Components -----------------------------------------

    // ----------------------------------------  TIMER -----------------------------------------
    Timer {
        id: timerRolagemTexto
        interval: 100
        triggeredOnStart: false; repeat: true; running: false
        onTriggered: function() {
            posicaoBarraDeRolagem += 0.005; // Lembre-se de dinamizar o incremento de position da scrollBar
            console.log("Size: " + scrollViewTextAreaTeleprompter.ScrollBar.vertical.size);
            console.log("posicaoBarraDeRolagem: " + posicaoBarraDeRolagem);
            if( posicaoBarraDeRolagem >= (1.0 - scrollViewTextAreaTeleprompter.ScrollBar.vertical.size) ) {
                timerRolagemTexto.stop();
            }
        }

    }
    // ----------------------------------------  TIMER -----------------------------------------

    // ----------------------------------------  View components -----------------------------------------
    Rectangle {
        id: retanguloTexto
        width: teleprompterTab.width * 95/100
        height: teleprompterTab.height * 25/100
        color: "transparent"
        border.width: 15
        border.color: "#2196F3"
        radius: 10
        anchors.horizontalCenter: parent.horizontalCenter

        Drag.active: dragArea.drag.active

        MouseArea {
            id: dragArea
            anchors.fill: parent
            drag.target: parent
            drag.maximumY: teleprompterTab.height * 60/100
            drag.minimumY: 0
            onPressed: function() {
                retanguloTexto.border.color = "#FFC107";
            }
            onReleased: function() {
                retanguloTexto.border.color = "#2196F3";
            }
        }

        Rectangle {
            id: rectTextoInternoRetanguloTexto
            width: retanguloTexto.width * 90/100
            height: retanguloTexto.height * 90/100
            anchors.centerIn: parent
            color: "transparent"

            ScrollView {
                id: scrollViewTextAreaTeleprompter
                height: rectTextoInternoRetanguloTexto.height
                width: rectTextoInternoRetanguloTexto.width
                ScrollBar.vertical.position: posicaoBarraDeRolagem
                ScrollBar.horizontal.policy: ScrollBar.AlwaysOff
                ScrollBar.horizontal.interactive: false
                ScrollBar.horizontal.hoverEnabled: false

                TextArea {
                    id: textAreaTeleprompter
                    color: "white"
                    readOnly: true
                    cursorVisible: false
                    activeFocusOnPress: false
                    font {
                        pointSize: 25
                        underline: false
                        italic: true
                        bold: true
                    }
                    horizontalAlignment: TextEdit.AlignHCenter
                    text: textoTeleprompterTabPrincipal
                    width: scrollViewTextAreaTeleprompter.width
                    height: scrollViewTextAreaTeleprompter.height
                    wrapMode: Text.Wrap
                }

            }

        }

    }

    Rectangle {
        id: rectEspacoBotoesGravacao
        width: teleprompterTab.width
        height: teleprompterTab.height * 10/100
        anchors.bottom: parent.bottom
        color: "black"
        opacity: 0.7

        GridLayout {
            id: gridBotoesGravacao
            anchors.fill: rectEspacoBotoesGravacao
            anchors.centerIn: rectEspacoBotoesGravacao
            columns: 3
            opacity: 1

            RoundButton {
                id: virarButton
                anchors.left: gridBotoesGravacao.left
                anchors.leftMargin: gridBotoesGravacao.width * 10/100
                //Material.background: "white"
                icon.name: "cameraSwitch"
                icon.source: "qrc:Imagens/Icones/cameraSwitch.png"
                antialiasing: true
                scale: 1.35
                onClicked: function() {
                    if( cameraEscolhida === 1 ) {
                        cameraEscolhida = 0;
                    } else if ( cameraEscolhida === 0 ) {
                        cameraEscolhida = 1;
                    }

                    console.log("Botão virar clickado");
                }
            }
            RoundButton {
                id: recordButton
                anchors.centerIn: gridBotoesGravacao
                property bool bandeiraIconPlay: true
                //Material.background: "white"
                icon.name: "playCircle"
                icon.source: "qrc:Imagens/Icones/playCircle.png"
                antialiasing: true
                scale: 1.6
                onClicked: function() {
                    if( bandeiraIconPlay ) {
                        recordButton.icon.source = "qrc:Imagens/Icones/stopCircle.png";
                        bandeiraIconPlay = false;

                        mediaRecorder.record();

                        timerRolagemTexto.start();

                        posicaoBarraDeRolagem = 0.0;


                    } else {
                        recordButton.icon.source = "qrc:Imagens/Icones/playCircle.png";
                        bandeiraIconPlay = true;

                        mediaRecorder.stop();

                        timerRolagemTexto.stop();

                    }
                    console.log("Botão gravar clickado");
                }
            }
            RoundButton {
                id: mudarVelocidadeTextoButton
                anchors.right: gridBotoesGravacao.right
                anchors.rightMargin: gridBotoesGravacao.width * 10/100
                //Material.background: "white"
                icon.name: "vel"
                icon.source: "qrc:Imagens/Icones/vel.png"
                antialiasing: true
                scale: 1.35
                onClicked: function() {
                    console.log("Botão velocidade de texto clickado");
                }
            }
        }

    }
}

