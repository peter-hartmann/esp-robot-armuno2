dofile('config-example.lua')
dofile('config.lua')

wifi.setmode(wifi.STATION)
if wifi.sta.status() == wifi.STA_GOTIP then
  dofile('ws.lua')
else
  wifi.eventmon.register(wifi.eventmon.STA_GOT_IP, function() dofile('ws.lua') end)
end
