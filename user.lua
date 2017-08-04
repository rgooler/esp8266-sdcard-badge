spi.setup(1, spi.MASTER, spi.CPOL_LOW, spi.CPHA_LOW, 8, 8)
vol = file.mount("/SD0", 8)

file.chdir('/SD0')
dofile('sduser.lua')
