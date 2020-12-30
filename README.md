# ESP8266 Nodemcu for armuno 2.0 from microbotlabs

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
