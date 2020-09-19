import QtQuick 2.7
import Ubuntu.Components 1.3
import Ubuntu.Components.Popups 1.3
//import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import Qt.labs.settings 1.0
import Qt.labs.platform 1.0
import QtQuick.Window 2.2
import "fn.js" as Helper

MainView {
    id: root
    objectName: 'mainView'
    applicationName: 'bitcoinwallet.mrcyjanek'
    automaticOrientation: true

    width: units.gu(45)
    height: units.gu(75)

    Timer {
        id: infohidetimer
        interval: 5000; running: false; repeat: false
        onTriggered: infoBanner.visible = false
    }
    Timer {
        id: refreshBal
        interval: 1000
        running: true
        repeat: true
        onTriggered: {
            Helper.rpcRequest("getbalance", null, function (a) {
                balanceLabel.text = Number(a.result).toFixed(8)+" BTC"
            })
        }
    }
    Button {
        id:infoBanner
        x:parent.width/2-width/2
        y:parent.height-400
        visible: false
        color: UbuntuColors.green
        width: parent.width
        function alert(txt) {
            infoBanner.text=txt
            infoBanner.visible=true
            infohidetimer.running=true
        }
    }
    Page {
        anchors.fill: parent

        header: PageHeader {
            id: header
            title: i18n.tr('Bitcoin Wallet')
        }
        Label {
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.top: header.bottom
            id: balanceLabel
            textSize: Label.XLarge
            color: "white"
            text: i18n.tr('X.XXXXXXXX BTC')
        }

        // Withdraw form

        Item {
            anchors.top: balanceLabel.bottom
            id: withdrawform
            width: parent.width
            visible: false
            TextField {
                anchors.top: balanceLabel.bottom
                visible: withdrawform.visible
                width: parent.width
                id: wdaddress
                placeholderText: i18n.tr("Bitcoin address")
            }
            TextField {
                anchors.top: wdaddress.top
                visible: withdrawform.visible
                width: parent.width
                id: wdamount
                placeholderText: i18n.tr("Amount in Bitcoin")
            }
            Button {
                anchors.top: wdamount.top
                visible: withdrawform.visible
                width: parent.width
                text: "Send"
            }
        }

        // end of withdraw form

        Button {
            id: deposit
            anchors.bottom: parent.bottom
            anchors.left: withdraw.right
            color: UbuntuColors.green
            width: parent.width*0.5
            height: units.gu(5)
            text: i18n.tr('Deposit')
            onClicked: {
                Helper.rpcRequest("getnewaddress", null, function (a) {
                    console.log(a)
                    var mimeData = Clipboard.newData();
                    mimeData.text = a.result;
                    Clipboard.push(mimeData);
                    infoBanner.alert("Copied to clipboard.");
                })
            }
        }
        Button {
            id: withdraw
            anchors.bottom: parent.bottom
            color: UbuntuColors.red
            width: parent.width*0.5
            height: units.gu(5)
            text: i18n.tr('Withdraw')
            onClicked: {
                withdrawform.visible = !withdrawform.visible;
            }
        }
    }
}
