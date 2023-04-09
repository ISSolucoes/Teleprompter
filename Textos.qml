import QtQuick
import QtQuick.Layouts
import QtQuick.Controls.Material

Item {
    id: itemTextos

    Component.onCompleted: function() {
        database.initDatabase();
        //database.deleteAll();
        let textos = database.readData();

        for(let indice = 0; indice < textos.length; indice++) {
            textoModel.append(textos[indice]);
        }
    };

    Rectangle {
        id: rectTextos
        anchors.fill: itemTextos
        color: "#EEEEEE"

        RoundButton {
            id: btnAddTexto
            Material.background: Material.Blue
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
            //ListElement { titulo: "Titulo ficticio"; texto: "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum." }
        }

        Component {
            id: componenteListaTexto

            Rectangle {
                id: rectItemPai
                width: rectTextos.width
                height: rectTextos.height * 10/100
                //Material.elevation: 5
                //padding: 0
                radius: 15

                //required property var model;
                property var modelo: model;
                //property int IDSelecionado: model.rowid
                property int indiceNoListModel: model.index
                property var ponteiroParaSwipe; // Necessário pois a variável swipe não está visivel dentro do componente de swipe.left

                SwipeDelegate {
                    id: swipeTextoDelegate
                    width: parent.width
                    height: parent.height

                    Component.onCompleted: function() {
                        ponteiroParaSwipe = swipe;
                    }

                    Popup {
                        id: popUpEditarTexto
                        //anchors.centerIn: rectTextos
                        topMargin: rectTextos.height * 12.5/100
                        bottomMargin: rectTextos.height * 12.5/100
                        leftMargin: (rectTextos.width * ((15/100)/2))
                        rightMargin: (rectTextos.width * ((15/100)/2))
                        width: rectTextos.width * 85/100
                        height: rectTextos.height * 85/100
                        modal: true
                        focus: true
                        closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside
                        contentItem: PopUpEditarTextos {
                            anchors.fill: popUpEditarTexto
                        }
                    }

                    onClicked: function() {
                        popUpEditarTexto.open();
                    }

                    ListView.onRemove: SequentialAnimation {
                        id: removeAnimationDelete
                        PropertyAction {
                            target: componenteListaTexto
                            property: "ListView.delayRemove"
                            value: true
                        }
                        NumberAnimation {
                            target: componenteListaTexto
                            property: "height"
                            to: 0
                        }
                        PropertyAction {
                            target: componenteListaTexto
                            property: "ListView.delayRemove"
                            value: false
                        }
                    }

                    // Dentro do componente de swipe.left, a variável swipe deixa de estar visivel
                    swipe.left: Rectangle {
                        id: retanguloUtilizar
                        width: parent.width * 30/100
                        height: parent.height
                        anchors.left: parent.left
                        color: retanguloUtilizar.SwipeDelegate.pressed ? "lightblue" : "lightgreen"
                        radius: 10

                        Image {
                            id: iconeUtilizar
                            anchors.centerIn: parent
                            source: "qrc:Imagens/Icones/done.png"
                        }

                        SwipeDelegate.onClicked: function() {
                            console.log(`id do item no db: ${model.rowid}`);
                            database.usarTexto(model.rowid);
                            model.isUsed = 1;
                            ponteiroParaSwipe.close();
                        }

                    }

                    swipe.right: Rectangle {
                        id: retanguloDeletar
                        width: parent.width * 30/100
                        height: parent.height
                        anchors.right: parent.right
                        color: retanguloDeletar.SwipeDelegate.pressed ? "tomato" : "#F44336"
                        radius: 10

                        Image {
                            id: iconeDelete
                            anchors.centerIn: parent
                            source: "qrc:Imagens/Icones/delete.png"

                        }

                        SwipeDelegate.onClicked: function() {
                            database.deleteById(model.rowid);

                            // limpando texto, para sumir o retangulo de texto na aba teleprompter, se o texto excluido for o texto usado na aba teleprompter(isUsed)
                            //console.log(JSON.stringify(model.isUsed))
                            if( Number(model.isUsed) === 1 ) {
                                textoTeleprompterTabPrincipal = "";
                            }

                            viewLista.model.remove(indiceNoListModel, 1); // se remove depois do banco de dados, pois se remover antes, o item deixa de existir no model e seu indice vira -1.

                        }
                    }

                    background: Rectangle {
                        id: rectItem
                        /*Layout.minimumWidth: parent.width
                        Layout.minimumHeight: parent.height*/
                        anchors.fill: rectItemPai
                        radius: rectItemPai.radius // Sem esta propriedade o rectItem passa as bordas do rectItemPai
                        color: "white"

                        MouseArea {
                            id: mouseAreaRectItem
                            anchors.fill: rectItem
                            onClicked: function() {
                                console.log(`Item clickado: titulo:${modelo.titulo} - texto: ${modelo.texto}`);
                                popUpEditarTexto.open();
                            }
                        }

                        ColumnLayout {
                            id: colunaTituloTextos
                            anchors.fill: rectItem
                            spacing: 0

                            Rectangle {
                                id: rectTitulo
                                Layout.minimumWidth: colunaTituloTextos.width
                                Layout.minimumHeight: colunaTituloTextos.height * 60/100
                                anchors {
                                    leftMargin: 0
                                    topMargin: 0
                                    rightMargin: 0
                                    bottomMargin: 0
                                }
                                color: "transparent"
                                Label {
                                    id: txtTitulo
                                    text: modelo.titulo
                                    font.pointSize: 30
                                    fontSizeMode: Text.Fit
                                }
                                clip: true
                            }

                            Rectangle {
                                id: rectTexto
                                Layout.minimumWidth: colunaTituloTextos.width
                                Layout.minimumHeight: colunaTituloTextos.height * 40/100
                                anchors {
                                    leftMargin: 0
                                    topMargin: 0
                                    rightMargin: 0
                                    bottomMargin: 0
                                }
                                color: "transparent"
                                Label {
                                    id: txtTexto
                                    text: modelo.texto
                                    font.pointSize: 20
                                    fontSizeMode: Text.Fit
                                    wrapMode: TextEdit.Wrap
                                }
                                clip: true
                            }

                        }

                    }

                }
            }


        }

        ListView {
            id: viewLista
            anchors.fill: parent
            spacing: 3
            topMargin: 3
            model: textoModel
            delegate: componenteListaTexto
            clip: true
        }
    }


}
