OLED_step = 0
OLED_max_steps = 3

OLED_timer_id = 0
OLED_timer_intv = 5000

function OLED_screens()
  if(OLED_max_steps == OLED_step) then
    OLED_step = 0
  end
  --Loops
  if(OLED_step == 0) then
    dofile("OLED_dcfur_off.lua")
  elseif(OLED_step == 1) then
    dofile("OLED_about.lua")
  elseif(OLED_step == 2) then
    dofile("OLED_wifi_mac.lua")
  end
  OLED_step = OLED_step + 1
end

tmr.alarm(OLED_timer_id, OLED_timer_intv, tmr.ALARM_AUTO, function()
  OLED_screens()
  end
  )
tmr.start(OLED_timer_id)