import QtQuick
import QtQuick.Layouts
import QtQuick.Controls.Material

Item {

    Rectangle {
        id: rectPopUpCriarTexto
        anchors.fill: parent
        color: "white"
        clip: true

        ColumnLayout {
            id: colunaAdcDados
            anchors.fill: rectPopUpCriarTexto

            TextArea {
                id: textAreaTituloCriar
                Layout.alignment: Qt.AlignLeft
                anchors.top: colunaAdcDados.top
                anchors.topMargin: 10
                anchors.leftMargin: 2
                font.pointSize: 25
                placeholderText: qsTr("Titulo")
                Layout.fillWidth: true
                Layout.minimumHeight: rectPopUpCriarTexto.height * 20/100
                Layout.maximumHeight: rectPopUpCriarTexto.height * 20/100
                wrapMode: TextEdit.Wrap
            }
            ScrollView {
                id: scrollViewTextAreaTextoCriar
                Layout.fillWidth: true
                anchors.topMargin: 10
                Layout.minimumHeight: rectPopUpCriarTexto.height * 60/100
                Layout.maximumHeight: rectPopUpCriarTexto.height * 60/100

                TextArea {
                    id: textAreaTextoCriar
                    Layout.alignment: Qt.AlignLeft
                    anchors.topMargin: 10
                    anchors.leftMargin: 2
                    font.pointSize: 20
                    placeholderText: qsTr("Texto")
                    Layout.fillWidth: true
                    Layout.minimumHeight: rectPopUpCriarTexto.height * 55/100
                    Layout.maximumHeight: rectPopUpCriarTexto.height * 55/100
                    wrapMode: TextEdit.Wrap
                }
            }


            Rectangle {
                id: rectLinhaBtns
                Layout.fillWidth: true
                Layout.minimumHeight: rectPopUpCriarTexto.height * 10/100

                Button {
                    id: btnAdicionar
                    anchors {
                        right: rectLinhaBtns.right
                        rightMargin: 10
                        bottomMargin: 0
                    }

                    Material.background: Material.Grey
                    text: qsTr("Adicionar texto")
                    onClicked: function adicionaTexto() {
                        let titulo = textAreaTituloCriar.text;
                        let texto = textAreaTextoCriar.text;
                        let JS_OBJ_texto = { titulo: titulo, texto: texto, rowid: 0 };

                        let id = database.storeData(JS_OBJ_texto);
                        JS_OBJ_texto.rowid = id;
                        textoModel.append(JS_OBJ_texto);

                        textAreaTituloCriar.text = "";
                        textAreaTextoCriar.text = "";

                        popUpCriarTexto.close();
                    }
                }

            }


        }

    }

}
