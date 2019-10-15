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

    Rectangle{
        color: "red"
    }

    ListView{
        id: songsList
        width: parent.width
        height: parent.height

        delegate: Text{
            anchors.fill: parent
            text: "Hello World"
        }
    }
}
