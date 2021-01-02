dofile('robot.lua')

if ws then ws:close() end

ws = websocket.createClient()
ws:on("connection", function(ws)
  print('got ws connection') ws:send('{"type":"Robot","id":"'..RobotId..'"}')
  tmr.create():alarm(1000, tmr.ALARM_AUTO, function() ws:send(state()) end)
end)
ws:on("close", function(_, status) print('connection closed', status) ws = nil end)
ws:on("receive", function(_, msg, opcode) control(msg) ws:send(state()) end)
ws:connect(WebServer)
