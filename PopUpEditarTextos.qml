import QtQuick
import QtQuick.Layouts
import QtQuick.Controls.Material
import QtQuick.LocalStorage

Item {

    Rectangle {
        id: rectPopUpEditarTexto
        anchors.fill: parent
        color: "white"
        clip: true

        Component.onCompleted: function() {
            textAreaTitulo.text = model.titulo;
            textAreaTexto.text = model.texto;
        }

        ColumnLayout {
            id: colunaEdtDados
            anchors.fill: rectPopUpEditarTexto
            TextArea {
                id: textAreaTitulo
                Layout.alignment: Qt.AlignLeft
                anchors.top: colunaEdtDados.top
                anchors.topMargin: 2
                anchors.leftMargin: 2
                font.pointSize: 35
                placeholderText: qsTr("Titulo")
                Layout.fillWidth: true
                Layout.preferredHeight: rectPopUpEditarTexto.height * 20/100
                wrapMode: TextEdit.Wrap
            }
            TextArea {
                id: textAreaTexto
                Layout.alignment: Qt.AlignLeft
                anchors.top: textAreaTitulo.bottom
                anchors.topMargin: 10
                anchors.leftMargin: 2
                font.pointSize: 20
                placeholderText: qsTr("texto")
                Layout.fillWidth: true
                Layout.preferredHeight: rectPopUpEditarTexto.height * 70/100
                wrapMode: TextEdit.Wrap
            }

            Rectangle {
                id: rectLinhaBtns
                Layout.fillWidth: true
                Layout.minimumHeight: rectPopUpEditarTexto.height * 10/100

                /*Button {
                    id: btnUsarTexto
                    anchors {
                        left: rectLinhaBtns.left
                        leftMargin: 10
                        bottomMargin: 0
                    }

                    Material.background: Material.Grey
                    text: qsTr("Usar texto")
                    onClicked: function usarTexto() {

                        let indiceNoListModel = model.index;
                        database.usarTexto(indiceNoListModel);

                        popUpEditarTexto.close();

                    }
                }*/

                Button {
                    id: btnEditar
                    anchors {
                        right: rectLinhaBtns.right
                        rightMargin: 10
                        bottomMargin: 0
                    }

                    Material.background: Material.Grey
                    text: qsTr("Editar texto")
                    onClicked: function editaTexto() {

                        let titulo = textAreaTitulo.text;
                        let texto = textAreaTexto.text;
                        let JS_OBJ_texto = { titulo: titulo, texto: texto, rowid: model.rowid };

                        // ------- a variável indiceNoListModel atualiza para -1 ao fazer a operação de "remove()", por isso armazena-la ------
                        let indiceParaRemover = indiceNoListModel;
                        let indiceParaInserir = indiceNoListModel;
                        // --------------------------------------------------------------------------------------------------------------------

                        database.updateData(model.rowid, JS_OBJ_texto);
                        textoModel.remove(indiceParaRemover, 1);
                        textoModel.insert(indiceParaInserir, JS_OBJ_texto);

                        popUpEditarTexto.close();

                    }
                }

            }

        }

    }

}
