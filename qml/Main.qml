import QtQuick 2.7
import Ubuntu.Components 1.3
//import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import Qt.labs.settings 1.0
import Qt.labs.platform 1.0
import "./fn.js" as Helper

MainView {
    id: root
    objectName: 'mainView'
    applicationName: 'bitcoinwallet.mrcyjanek'
    automaticOrientation: true

    width: units.gu(45)
    height: units.gu(75)

    Page {
        anchors.fill: parent

        header: PageHeader {
            id: header
            title: i18n.tr('Bitcoin Wallet')
        }

        ColumnLayout {
            spacing: units.gu(2)
            anchors {
                margins: units.gu(2)
                top: header.bottom
                left: parent.left
                right: parent.right
                bottom: parent.bottom
            }

            Item {
                Layout.fillHeight: true
            }

            Label {
                id: label
                Layout.alignment: Qt.AlignHCenter
                text: 'test'
            }
            Button {
                Layout.alignment: Qt.AlignHCenter
                text: i18n.tr('Press here!')
                onClicked: {

                }
            }
            Item {
                Layout.fillHeight: true
            }
        }
    }
}
