wifi.setphymode(wifi.PHYMODE_G)
wifi.ap.setmac("13-37-00-00-00-00")
dhcp_config ={start = "192.168.1.100"}
wifi.ap.dhcp.config(dhcp_config)

mdns.register("fileserver", { description="Jippen's esp8266 File Server", service="http", port=80, location='Jippen' })
dofile('OLED_loop.lua')
if file.exists("http-init.lc") then
   dofile("http-init.lc")
else
   dofile("http-init.lua")
end