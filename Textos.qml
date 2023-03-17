import QtQuick
import QtQuick.Layouts
import QtQuick.Controls.Material

Item {
    id: itemTextos

    Rectangle {
        id: rectTextos
        anchors.fill: itemTextos

        RoundButton {
            id: btnAddTexto
            icon.color: Material.Indigo
            icon.name: "add_texto"
            icon.source: "qrc:Imagens/Icones/add_texto.png"
            z: 2
            anchors.right: rectTextos.right
            anchors.bottom: rectTextos.bottom
            anchors.rightMargin: 25
            anchors.bottomMargin: 25
            antialiasing: true
            scale: 1.7
            onClicked: function() {
                popUpCriarTexto.open();
            }
        }

        Popup {
            id: popUpCriarTexto
            anchors.centerIn: rectTextos
            topMargin: rectTextos.height * 12.5/100
            width: rectTextos.width * 85/100
            height: rectTextos.height * 85/100
            modal: true
            focus: true
            closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside
            //contentItem: conteudoPopUpCriarTexto
            contentItem: PopUpCriarTextos {
                anchors.fill: popUpCriarTexto
            }
        }


        ListModel {
            id: textoModel
            ListElement { titulo: "Exemplo"; texto: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum." }
        }

        Component {
            id: textoDelegate

            ColumnLayout {
                id: colunaPrincipal
                anchors.fill: rectTextos
                spacing: 0
                z: 1

                Popup {
                    id: popUpEditarTexto
                    anchors.centerIn: colunaPrincipal
                    topMargin: rectTextos.height * 12.5/100
                    width: rectTextos.width * 85/100
                    height: rectTextos.height * 85/100
                    modal: true
                    focus: true
                    closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside
                    contentItem: PopUpEditarTextos {
                        anchors.fill: popUpEditarTexto
                    }
                }

                Rectangle {
                    id: rectItem
                    //color: "green"
                    Layout.preferredWidth: rectTextos.width
                    Layout.preferredHeight: rectTextos.height * 10/100
                    Layout.leftMargin: 5

                    MouseArea {
                        id: mouseAreaRectItem
                        anchors.fill: rectItem
                        onClicked: function() {
                            console.log(`Item clickado: titulo:${model.titulo} - texto: ${model.texto}`);
                            popUpEditarTexto.open();
                        }
                    }

                    ColumnLayout {
                        id: colunaTituloTextos
                        anchors.fill: rectItem
                        spacing: 0

                        Rectangle {
                            id: rectTitulo
                            Layout.preferredWidth: colunaTituloTextos.width
                            Layout.preferredHeight: colunaTituloTextos.height * 60/100
                            Text {
                                id: txtTitulo
                                text: model.titulo
                                font.pointSize: 30
                            }
                        }

                        Rectangle {
                            id: rectTexto
                            Layout.preferredWidth: colunaTituloTextos.width
                            Layout.preferredHeight: colunaTituloTextos.height * 40/100
                            Label {
                                id: txtTexto
                                text: model.texto
                                font.pointSize: 20
                                wrapMode: TextEdit.Wrap
                            }
                        }

                    }

                }

            }




        }


        ListView {
            id: viewLista
            anchors.fill: parent
            model: textoModel
            delegate: textoDelegate
            clip: true
        }
    }


}
