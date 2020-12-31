pwm2.stop()
dofile('robot_state.lua')

function state()
  local s = ''
  for k,v in pairs(robot) do s = s..k..'='..v.cur..' ' end
  return s
end

function control(seq)
  for k,v in string.gmatch(seq, "(%w+)=(-?%w+)") do
    k,v = robot[k],tonumber(v)
    if k and v then
      k.cur = k.cur + v
      if k.cur > k.max then k.cur = k.max end
      if k.cur < k.min then k.cur = k.min end
      pwm2.set_duty(k.pin,k.cur)
    end
  end
  print(state())
end

for k,v in pairs(robot) do pwm2.setup_pin_hz(robot[k].pin,50,200,robot[k].cur) end
pwm2.start()
