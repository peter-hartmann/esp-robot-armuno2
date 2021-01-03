-- copy this file to config.lua
SetupName = 'Robot-'..string.format("%X",node.chipid())
SetupPassword = 'password123'
RobotId = 'Robot-'..string.format("%X",node.chipid())
WebServer = 'wss://echo.websocket.org'
AutoOffInSec = 60