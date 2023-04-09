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
            textAreaTituloEditar.text = model.titulo;
            textAreaTextoEditar.text = model.texto;
        }

        ColumnLayout {
            id: colunaEdtDados
            anchors.fill: rectPopUpEditarTexto
            TextArea {
                id: textAreaTituloEditar
                Layout.alignment: Qt.AlignLeft
                anchors.top: colunaEdtDados.top
                anchors.topMargin: 10
                anchors.leftMargin: 2
                font.pointSize: 35
                placeholderText: qsTr("Titulo")
                Layout.fillWidth: true
                Layout.minimumHeight: rectPopUpEditarTexto.height * 20/100
                Layout.maximumHeight: rectPopUpEditarTexto.height * 20/100
                wrapMode: TextEdit.Wrap
            }

            ScrollView {
                id: scrollViewTextAreaTextoEditar
                Layout.fillWidth: true
                anchors.topMargin: 10
                Layout.minimumHeight: rectPopUpEditarTexto.height * 60/100
                Layout.maximumHeight: rectPopUpEditarTexto.height * 60/100

                TextArea {
                    id: textAreaTextoEditar
                    Layout.alignment: Qt.AlignLeft
                    anchors.topMargin: 10
                    anchors.leftMargin: 2
                    font.pointSize: 20
                    placeholderText: qsTr("Texto")
                    Layout.fillWidth: true
                    Layout.minimumHeight: rectPopUpEditarTexto.height * 55/100
                    Layout.maximumHeight: rectPopUpEditarTexto.height * 55/100
                    wrapMode: TextEdit.Wrap
                }
            }


            Rectangle {
                id: rectLinhaBtns
                Layout.fillWidth: true
                Layout.minimumHeight: rectPopUpEditarTexto.height * 10/100

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

                        let titulo = textAreaTituloEditar.text;
                        let texto = textAreaTextoEditar.text;
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
