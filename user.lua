wifi.setphymode(wifi.PHYMODE_G)
wifi.ap.setmac("13-37-00-00-00-00")
dhcp_config ={start = "192.168.1.100"}
wifi.ap.dhcp.config(dhcp_config)

mdns.register("fileserver", { description="Jippen's esp8266 File Server", service="http", port=80, location='Jippen' })
dofile('OLED_dcfur_on.lua')
dofile('OLED_loop.lua')
dofile('http-init.lua')
