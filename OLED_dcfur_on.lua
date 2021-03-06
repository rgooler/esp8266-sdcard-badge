file.open("dcon.xbm", "r")
img = file.read()
file.close()

-- Init the display
sla = 0x3C
disp = u8g.ssd1306_128x64_i2c(sla)
disp:setFont(u8g.font_6x10)
disp:setFontRefHeightExtendedText()
disp:setDefaultForegroundColor()
disp:setFontPosTop()

disp:firstPage()
repeat
    disp:drawXBM(0, 0, 127, 63, img)
until disp:nextPage() == false