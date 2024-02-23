#
# https://easymcp2221.readthedocs.io/en/latest/examples.html
#
# I2C Slave helper
#
################################################################

import EasyMCP2221
from time import sleep

# Connect to MCP2221
mcp = EasyMCP2221.Device()

# Create two I2C Slaves
pcf    = mcp.I2C_Slave(0x22) # 8 bit ADC
#eeprom = mcp.I2C_Slave(0x50) # serial memory

# Setup analog reading (and ignore the first value)
pcf.read_register(0b00000001)

# print("Storing...")
for position in range (0, 10):
    v = pcf.read()
    #eeprom.write_register(position, v, reg_bytes=2)
    
    sleep(1)

# # Dump the 10 values
# v = eeprom.read_register(0x0000, 10, reg_bytes=2)

print("Data: ")
print(list(v))