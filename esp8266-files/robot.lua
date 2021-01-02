pwm2.stop()
dofile('robot_state.lua')

function state()
  local s = ''
  for k,v in pairs(robot) do s = s..k..'='..v.cur..' ' end
  if standing == 0 then s = s..'; moving' end
  return s
end

function control(seq)
  for k,a,v in string.gmatch(seq, "(%w+)([+=])(-?%w+)") do
    k,v = robot[k],tonumber(v)
    if k and v then
      if a == '=' then k.trg = 0 end
      k.trg = k.trg + v
      if k.trg > k.max then k.trg = k.max end
      if k.trg < k.min then k.trg = k.min end
      if k.trg ~= k.cur then standing = 0 end
    end
  end
  print(state())
end

for k,v in pairs(robot) do
  robot[k].trg = robot[k].cur
  pwm2.setup_pin_hz(robot[k].pin,50,robot_steps,robot[k].cur)
end
pwm2.start()

standing = 0
t_ms = 40
t_stop = AutoOffInSec * 1000 / t_ms
gpio.mode(4, gpio.OUTPUT)
tmr.create():alarm(t_ms, tmr.ALARM_AUTO, function()
  standing = standing + 1
  for k,v in pairs(robot) do
    if k == 'gr' and v.trg ~= v.cur then v.cur = v.trg pwm2.set_duty(v.pin,v.cur) standing = 0 end
    if v.trg > v.cur then v.cur = v.cur + 1 pwm2.set_duty(v.pin,v.cur) standing = 0 end
    if v.trg < v.cur then v.cur = v.cur - 1 pwm2.set_duty(v.pin,v.cur) standing = 0 end
  end
  if standing < t_stop
  then gpio.write(4,0) pwm2.start()
  else gpio.write(4,1) pwm2.stop()
  end
end)
