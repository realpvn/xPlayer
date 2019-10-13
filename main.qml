import QtQuick 2.12
import QtQuick.Window 2.12
import QtMultimedia 5.9
import QtQuick.Controls 2.5
import QtQuick.Dialogs 1.2

Window {
    id: root
    visible: true
    width: 640
    height: 480
    title: qsTr("Hello World")

    Audio{
        id: player
    }

    Image {
        id: image
        width: 250
        height: 250
        anchors.horizontalCenter: parent.horizontalCenter
        source: "images/music-default.png"
    }

    TextArea{
        id:songName
        anchors.bottom: image.bottom
        readOnly: true
        anchors.horizontalCenter: parent.horizontalCenter
        topPadding: 200
        font.pixelSize: 14
        text: {
            player.metaData.title === undefined? "Select a song": player.metaData.title
        }
    }



    Row{
        id: controlsRow
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        spacing: 10
        Button{
            id: playPauseBtn
            text: {
                if(player.playbackState === 1)
                    return "Pause"
                else
                    return "Play"
            }
            font.family: "Montserrat"
            font.weight: Font.DemiBold
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
            font.family: "Montserrat"
            font.weight: Font.DemiBold
            anchors.bottom: playPauseBtn.bottom
            onClicked: fileDialog.open()
        }
        Button{
            text: "New window"
            font.family: "Montserrat"
            font.weight: Font.DemiBold
            anchors.bottom: openBtn.bottom
            onClicked: {
                var component = Qt.createComponent("child.qml");
                win = component.createObject(root);
                win.show();
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
