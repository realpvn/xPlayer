import QtQuick 2.12
import QtQuick.Window 2.12
import QtMultimedia 5.9
import QtQuick.Controls 2.5
import QtQuick.Dialogs 1.2
import QtQuick.Controls.Styles 1.4

Window {
    id: root
    visible: true
    width: 640
    height: 480
    title: qsTr("xPlayer - World's Music Player")
    color: "#eee"

    Audio{
        id: player
        property int songIndex: 0
        autoPlay: true
    }

    Column{
        id: firstRow
        width: root.width/2
        anchors.horizontalCenter: parent.horizontalCenter
        spacing: 5
        Image {
            id: image
            width: 250
            height: 250
            anchors.horizontalCenter: parent.horizontalCenter
            source: "images/music-default.png"
        }
        TextArea{
            id:songName
            font.family: "Montserrat"
            font.weight: Font.DemiBold
            anchors.horizontalCenter: parent.horizontalCenter
            readOnly: true
            font.pixelSize: 14
            text: {
                if(player.hasAudio === false)
                    return "Browse song"
                else if(player.metaData.title === undefined && player.hasAudio === true)
                    return player.source
                else
                    return player.metaData.title
            }
            color: "#494949"
        }
        ProgressBar{
            id: control
            background: Rectangle {
                implicitWidth: width
                implicitHeight: 6
                color: "#e6e6e6"
                radius: width/2
                border.color: "#ddd"
            }

            contentItem: Rectangle {
                anchors.left: control.left
                anchors.verticalCenter: control.verticalCenter
                width: control.visualPosition * control.width
                height: control.height
                radius: width/2
                color: {
                    player.hasAudio === true? "#FB3741": "#e6e6e6"
                }

                z:101
            }
            width: parent.width
            from: 0
            to: player.duration
            value: player.position
        }
    }

    Row{
        id: controlsRow
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom
        spacing: 10
        bottomPadding: 15
        Button{
            id: openBtn
            text: "Browse"
            font.family: "Montserrat"
            font.weight: Font.DemiBold
            font.pixelSize: 11
            anchors.bottom: playPauseBtn.bottom
            onClicked: fileDialog.open()
        }

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
            font.pixelSize: 11
            onClicked: {
                if(player.playbackState === 1){
                    player.pause()
                }else
                    player.play()
            }
        }
        Button{
            text: "Next"
            font.family: "Montserrat"
            font.weight: Font.DemiBold
            font.pixelSize: 11
            onClicked: {
                player.songIndex++
                player.source = songModel.get(player.songIndex).songUrl
            }
        }
        Button{
            text: "Playlist"
            font.family: "Montserrat"
            font.weight: Font.DemiBold
            font.pixelSize: 11
            anchors.bottom: openBtn.bottom
            onClicked: playlistWindow.show()
        }

        Window {
            id: playlistWindow
            width: 640
            height: 480

            ListModel {
                id: songModel
            }

            ListView {
                width: parent.width
                implicitHeight: 200
                model: songModel

                delegate: Text {
                    width: parent.width
                    height: 20
                    text:  {
                        text: songUrl
                    }
                    MouseArea{
                        onClicked: {
                            console.log('in')
                            player.songIndex = this.songIndex
                            player.source = songModel.get(player.songIndex).songUrl
                        }
                    }

                    color: index % 2 === 0 ? "red" : "blue "
                }
            }
        }

        FileDialog{
            id: fileDialog
            folder: shortcuts.home
            nameFilters: "*.mp3"
            onAccepted: {
                var fileUrl = "" +this.fileUrl
                console.log(songModel.count)
                songModel.insert(songModel.count, {"songUrl": fileUrl, "index": songModel.count})
                player.source = songModel.get(player.songIndex).songUrl
            }
        }
    }
}
