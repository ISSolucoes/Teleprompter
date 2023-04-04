import QtQuick
import QtQuick.Controls.Material
import QtMultimedia
import QtQuick.Layouts

Item {

    property real posicaoBarraDeRolagem: 0.0
    property int cameraEscolhida: 1

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
            active: true
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
            posicaoBarraDeRolagem += 0.0025; // Lembre-se de dinamizar o incremento de position da scrollBar
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
        x: (teleprompterTab.width * 5/100)/2
        color: "transparent"
        border.width: 15
        border.color: "#5cb2f7"
        radius: 10
        //anchors.horizontalCenter: parent.horizontalCenter
        visible: textAreaTeleprompter.contentWidth > 0 ? true : false

        Drag.active: dragArea.drag.active

        MouseArea {
            id: dragArea
            anchors.fill: parent
            drag.target: parent
            drag.maximumY: teleprompterTab.height * 60/100
            drag.minimumY: 0
            drag.maximumX: teleprompterTab.width - retanguloTexto.width
            drag.minimumX: 0
            drag.axis: Drag.XAndYAxis
            onPressed: function() {
                retanguloTexto.border.color = "#2196F3";
            }
            onReleased: function() {
                retanguloTexto.border.color = "#5cb2f7";
            }
        }

        Rectangle {
            id: rectTextoInternoRetanguloTexto
            //width: retanguloTexto.width * 90/100
            //height: retanguloTexto.height * 90/100
            anchors.fill: parent
            anchors.margins: retanguloTexto.border.width
            anchors.centerIn: parent
            color: "black"
            opacity: 0.7

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
        //height: teleprompterTab.height * 10/100
        implicitHeight: recordButton.height + (recordButton.height * 20/100)
        anchors.bottom: parent.bottom
        color: "black"
        opacity: 1

        GridLayout {
            id: gridBotoesGravacao
            anchors.fill: rectEspacoBotoesGravacao
            anchors.centerIn: rectEspacoBotoesGravacao
            columns: 3

            RoundButton {
                id: virarButton
                anchors.left: gridBotoesGravacao.left
                anchors.leftMargin: gridBotoesGravacao.width * 10/100
                //Material.background: "white"
                icon.name: "cameraSwitch"
                icon.source: "qrc:Imagens/Icones/cameraSwitch.png"
                antialiasing: true
                scale: 1.25
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

                icon.name: "playCircle"
                icon.source: "qrc:Imagens/Icones/playCircle.png"
                antialiasing: true
                scale: 1.4
                onClicked: function() {
                    if( bandeiraIconPlay ) {
                        recordButton.icon.source = "qrc:Imagens/Icones/stopCircle.png";
                        bandeiraIconPlay = false;

                        mediaRecorder.record();

                        timerRolagemTexto.start();

                        posicaoBarraDeRolagem = 0.0;

                        virarButton.visible = false;
                        mudarVelocidadeTextoButton.visible = false;


                    } else {
                        recordButton.icon.source = "qrc:Imagens/Icones/playCircle.png";
                        bandeiraIconPlay = true;

                        mediaRecorder.stop();

                        timerRolagemTexto.stop();

                        virarButton.visible = true;
                        mudarVelocidadeTextoButton.visible = true;

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
                scale: 1.25
                onClicked: function() {
                    console.log("Botão velocidade de texto clickado");
                }
            }
        }

    }
}

