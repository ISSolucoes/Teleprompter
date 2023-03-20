import QtQuick
import QtMultimedia
import QtQuick.Controls.Material
import QtQuick.Layouts
import QtQuick.LocalStorage

//import "./Teleprompter.qml"
//import "./Database.qml" // Não precisa do import pois os arquivos estão no mesmo nivel

ApplicationWindow {
    id: root
    visible: true
    title: qsTr("Teleprompter")
    color: "black"
    Material.accent: Material.Blue

    property string textoTeleprompterTabPrincipal: "exemplo";

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

    Database {
        id: database
        onEmiteTextoUsado: function(textoUsado) {
            console.log("Entrou db usado");
            textoTeleprompterTabPrincipal = textoUsado;
        }
    }


}
