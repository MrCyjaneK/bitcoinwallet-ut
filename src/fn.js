function rpcRequest(method, params = [], callback) {
    console.log('rpcRequest', method, params)
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
                "id":"somerandomid",
                "method": method,
                "params": params
            });
            sendRequest.onreadystatechange = function () {
                if (sendRequest.readyState == XMLHttpRequest.DONE) {
                    console.log(JSON.parse(sendRequest.responseText))
                    callback(sendRequest.responseText)
                }
            }
            sendRequest.open('POST', url, true);
            sendRequest.send(params)
        }
    };
    getCookie.send();
}
