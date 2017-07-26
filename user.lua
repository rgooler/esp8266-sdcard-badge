wifi.setphymode(wifi.PHYMODE_G)
wifi.setmode(wifi.SOFTAP, true)
cfg ={
	ssid="Jippen's Fileserver",
	auth=wifi.OPEN,
	channel=11
}
wifi.ap.config(cfg)

cfg = {
	ip="192.168.1.1",
    netmask="255.255.255.0",
    gateway="192.168.1.1",
}
wifi.ap.setip(cfg)

wifi.ap.setmac("13-37-00-00-00-00")


dhcp_config ={start = "192.168.1.100"}
wifi.ap.dhcp.config(dhcp_config)

mdns.register("fileserver", { description="Jippen's esp8266 File Server", service="http", port=80, location='Jippen' })
dofile('OLED_loop.lua')