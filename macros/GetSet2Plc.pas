// 98 ms
macro_command main()

unsigned char statusUp = 0
unsigned char statusDown = 0


GetDataEx(statusUp, "Siemens S7-1200/S7-1500", "PLC.Blocks.main_DB.statusUpHMI", 1)
SetData(statusUp, "Local HMI", LW, 80, 1)

GetDataEx(statusDown, "Siemens S7-1200/S7-1500", "PLC.Blocks.main_DB.statusDownHMI", 1)
SetData(statusDown, "Local HMI", LW, 86, 1)


end macro_command