"use strict";

const serverPort = 7777,
    http = require("http"),
    express = require("express"),
    app = express(),
    server = http.createServer(app),
    WebSocket = require("ws"),
    websocketServer = new WebSocket.Server({ server }),
    path = require('path');

//when a websocket connection is established
websocketServer.on('connection', (webSocketClient) => {
    webSocketClient.on('message', (message) => {
        console.log('message', isRobot(webSocketClient) ? 'Robot' : '-----', message)
        if (message[0] === '{') {
            webSocketClient.data = JSON.parse(message);
            info_for_human();
            return;
        }
        // boadcast between robot and browser client
        [...websocketServer.clients]
            .filter(client => isRobot(webSocketClient) != isRobot(client))
            .forEach(client => client.send(message));
    });
});

function isRobot(wsc) { return (wsc.data && wsc.data.type === 'Robot') ? true : false; }
function info_for_human() {
    [...websocketServer.clients]
        .filter(client => !isRobot(client))
        .forEach(client => {
            const info = { connections: [...websocketServer.clients].map(({ data }) => data) };
            client.send(JSON.stringify(info));
        });
}

setInterval(info_for_human, 10000);

//start the web server
server.listen(serverPort, () => {
    console.log(`Websocket server started on port ` + serverPort);
});

app.use(express.static(path.join(__dirname, 'public'))); //  "public" off of current is root
