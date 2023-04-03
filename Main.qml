import QtQuick
import QtMultimedia
import QtQuick.Controls.Material
import QtQuick.Layouts
import QtQuick.LocalStorage

ApplicationWindow {
    id: root
    visible: true
    title: qsTr("Teleprompter")
    color: "black"
    Material.accent: Material.Blue

    property string textoTeleprompterTabPrincipal: "";

    Database {
        id: database
        onEmiteTextoUsado: function(textoUsado) {
            textoTeleprompterTabPrincipal = textoUsado;
        }
    }

    header: ToolBar {
        id: toolBar
        position: ToolBar.Header
        RowLayout {
            id: linhaToolBar
            anchors.fill: parent
            Label {
                id: tituloToolBar
                text: "Teleprompter"
                font.pointSize: 23
                horizontalAlignment: Qt.AlignHCenter
                verticalAlignment: Qt.AlignVCenter
                Layout.fillWidth: true
            }
        }

    }

    footer: TabBar {
        id: tabBar
        TabButton {
            id: teleprompter
            icon.name: "Teleprompter"
            icon.source: "qrc:Imagens/Icones/video.png"
            //text: "Teleprompter"
        }
        TabButton {
            id: textos
            icon.name: "Textos"
            icon.source: "qrc:Imagens/Icones/texto.png"
            //text: "Textos"
        }
    }

    StackLayout {
        id: pilhaLayout
        anchors.fill: parent
        currentIndex: tabBar.currentIndex
        antialiasing: true

        Item {
            id: teleprompterTab
            Teleprompter {
                anchors.fill: teleprompterTab
            }
        }

        Item {
            id: textosTab
            Textos {
                anchors.fill: textosTab
            }
        }

    }


}
