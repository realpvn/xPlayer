import QtQuick 2.12
import QtQuick.Window 2.12
import QtMultimedia 5.9
import QtQuick.Controls 2.5
import QtQuick.Dialogs 1.2

Window {
    visible: true
    width: 640
    height: 480
    title: qsTr("Player")

    Audio{
        id: player
        //source: "C:/Users/pawan/Desktop/Inkem-Inkem.mp3"
        autoLoad: true
        autoPlay: true
    }

    Row{
        anchors.horizontalCenter: parent.horizontalCenter
        spacing: 10
        Button{
            id: playPauseBtn
            text: {
                console.log(player.playbackState)
                if(player.playbackState === 1)
                    return "Pause"
                else
                    return "Play"
            }
            onClicked: {
                if(player.playbackState === 1){
                    player.pause()
                }else
                    player.play()
            }
        }

        Button{
            id: openBtn
            text: "Open"
            anchors.bottom: playPauseBtn.bottom
            onClicked: fileDialog.open()
        }
        Button{
            text: "New window"
            anchors.bottom: openBtn.bottom
            onClicked: {
                function createWindows() {
                     var component = Qt.createComponent("Child.qml");
                     console.log("Component Status:", component.status, component.errorString());
                     var window = component.createObject(root, {"x": 100, "y": 300});
                     window.show();
                    }
            }
        }
        FileDialog{
            id: fileDialog
            folder: shortcuts.home
            nameFilters: "*.mp3"
            onAccepted: {
                player.source = this.fileUrl
            }
        }
    }
}
