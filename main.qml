import QtQuick
import QtMultimedia
import QtQuick.Controls.Material
import QtQuick.Layouts

//import "./Teleprompter.qml"

ApplicationWindow {
    id: root
    visible: true
    title: qsTr("Teleprompter")
    color: "black"
    Material.accent: Material.Blue


    footer: TabBar {
        id: tabBar
        TabButton {
            id: teleprompter
            icon.name: "Teleprompter"
            text: "Teleprompter"
        }
        TabButton {
            id: textos
            icon.name: "Textos"
            text: "Textos"
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


}
