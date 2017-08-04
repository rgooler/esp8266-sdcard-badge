-- Init the display
sla = 0x3C
disp = u8g.ssd1306_128x64_i2c(sla)
disp:setFont(u8g.font_chikita)
disp:setFontRefHeightExtendedText()
disp:setDefaultForegroundColor()
disp:setFontPosTop()

disp:firstPage()
repeat
    disp:drawFrame(2,2,126,62)
    disp:drawStr(8, 6, "Connected MAC Addresses")
    counter = 20
    for mac,_ in pairs(wifi.ap.getclient()) do
        disp:drawStr(28, counter, mac)
        counter = counter + 10
    end
until disp:nextPage() == false