dofile('robot.lua')

if ws then ws:close() end

ws = websocket.createClient()
ws:on("connection", function(ws) print('got ws connection') ws:send('{id:"'..RobotId..'"}') end)
ws:on("close", function(_, status) print('connection closed', status) ws = nil end)
ws:on("receive", function(_, msg, opcode) control(msg) end)
ws:connect(WebServer)
