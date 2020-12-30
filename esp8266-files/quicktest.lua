-- 5 grabber
-- 6 left-right
-- 7 forth-back
-- 8 up-down
seq={[5]={22,12},[6]={10,20},[7]={16,12},[8]={22,13}}
t,n=1500000,5
for k,v in pairs(seq) do pwm2.setup_pin_hz(k,50,200,15) end
pwm2.start()
for i=1,n do
  print(i)
  for k,v in pairs(seq) do pwm2.set_duty(k,v[1+i%2]) end
  tmr.delay(t)
end
pwm2.stop()
