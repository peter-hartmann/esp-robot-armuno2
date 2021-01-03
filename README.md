# ESP8266 Nodemcu for armuno 2.0 from microbotlabs

... work in progress!

lua modules
```
enduser_setup, file, gpio, http, net, node, pwm, pwm2, tmr, uart, websocket, wifi
```

```
-- grabber
pin,b,e,t,n = 5,22,12,1000000,3

-- left-right
pin,b,e,t,n = 6,5,24,1000000,3

-- forth-back
pin,b,e,t,n = 7,16,12,1000000,3

-- up-down
pin,b,e,t,n = 8,22,13,1000000,3

-- 50Hz
pwm2.setup_pin_hz(pin,50,200,b)
pwm2.start()
for i=1,n do
  print(i)
  pwm2.set_duty(pin, b)
  tmr.delay(t)
  pwm2.set_duty(pin, e)
  tmr.delay(t)
end
pwm2.stop()
```

# DNS resolution test
```
sk = net.createConnection(net.TCP, 0)
sk:dns("www.nodemcu.com", function(conn, ip) print(ip) end)
sk = nil
ws:connect('ws://echo.websocket.org')
```

# Wifi setup
```
wifi.sta.disconnect()
wifi.setmode(wifi.STATIONAP)
wifi.ap.config({ssid=SetupName,auth=wifi.WPA2_PSK,pwd=SetupPassword})
enduser_setup.manual(true)
enduser_setup.start()
```

# Program examples

```
lr=56 ud=75 fb=30 gr=48
lr=56 ud=82 fb=38 gr=48
lr=56 ud=82 fb=38 gr=63
lr=56 ud=82 fb=38 gr=48
lr=56 ud=87 fb=47 gr=48
lr=91 ud=87 fb=47 gr=48
lr=91 ud=87 fb=47 gr=63
lr=91 ud=75 fb=63 gr=63
lr=91 ud=75 fb=63 gr=50
lr=91 ud=75 fb=63 gr=48
lr=91 ud=88 fb=63 gr=48
lr=91 ud=88 fb=53 gr=48
lr=26 ud=88 fb=53 gr=48
lr=26 ud=63 fb=53 gr=48
lr=26 ud=63 fb=53 gr=50
lr=26 ud=63 fb=53 gr=63
lr=26 ud=87 fb=47 gr=63
lr=91 ud=87 fb=47 gr=63
lr=91 ud=69 fb=68 gr=63
lr=91 ud=69 fb=68 gr=50
lr=91 ud=69 fb=68 gr=48
lr=91 ud=85 fb=57 gr=48
lr=26 ud=85 fb=55 gr=48
lr=26 ud=73 fb=50 gr=48
lr=26 ud=73 fb=50 gr=50
lr=26 ud=73 fb=50 gr=63
lr=26 ud=88 fb=44 gr=63
lr=56 ud=88 fb=38 gr=48
lr=56 ud=82 fb=38 gr=48
lr=56 ud=82 fb=38 gr=63
lr=56 ud=82 fb=38 gr=48
lr=56 ud=75 fb=30 gr=48
```