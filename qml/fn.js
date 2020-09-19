function rpcRequest(method, params, callback) {
    //console.log('rpcRequest', method)
    var port = 10001;
    var authstring = "";
    var getCookie = new XMLHttpRequest;
    getCookie.open("GET", StandardPaths.writableLocation(StandardPaths.AppDataLocation)+"/.cookie");
    getCookie.onreadystatechange = function() {
        if (getCookie.readyState == XMLHttpRequest.DONE) {
            authstring = getCookie.responseText;
            var sendRequest = new XMLHttpRequest();
            var url = 'http://'+authstring+"@127.0.0.1:"+port+"/";
            var data = JSON.stringify({
                "jsonrpc":"1.0",
                "id": Math.random(),
                "method": method,
                "params": params
            });
            console.log(data)
            sendRequest.onreadystatechange = function () {
                if (sendRequest.readyState == XMLHttpRequest.DONE) {
                    var respJSON = JSON.parse(sendRequest.responseText)
                    if (respJSON.error) {
                        console.log(JSON.stringify(respJSON.error));
                        //qml: {"code":-28,"message":"Loading block index..."}
                        infoBanner.alert("Error: "+respJSON.error.code+" '"+respJSON.error.message+"' when calling method '"+method+"'")
                    } else {
                        console.log(JSON.stringify(respJSON))
                        callback(respJSON)
                    }
                }
            }
            sendRequest.open('POST', url, true);
            sendRequest.send(data)
        }
    };
    getCookie.send();
}
