-- Init the display
sla = 0x3C
i2c.setup(0, 1, 2, i2c.SLOW)
disp = u8g.ssd1306_128x64_i2c(sla)
disp:setFont(u8g.font_6x10)
disp:setFontRefHeightExtendedText()
disp:setDefaultForegroundColor()
disp:setFontPosTop()

disp:firstPage()
repeat
    disp:drawFrame(2,2,126,62)
    disp:drawStr(8, 6, "Jippen's Fileserver")
    disp:drawStr(8, 16, "http://" .. wifi.ap.getip())
    disp:drawStr(8, 36, "   Have phun!")

until disp:nextPage() == false