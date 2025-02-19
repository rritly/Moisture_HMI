// 136ms
macro_command main()

short allStatus = 0
bool SW1Up = false
bool SW2Down = false


GetDataEx(allStatus, "Siemens S7-1200/S7-1500", "PLC.Blocks.main_DB.allStatus", 1)
SetData(allStatus, "Local HMI", LW, 92, 1)

GetDataEx(SW1Up, "Siemens S7-1200/S7-1500", "PLC.Blocks.main_DB.SW1Up", 1)
SetData(SW1Up, "Local HMI", LB, 50, 1)

GetDataEx(SW2Down, "Siemens S7-1200/S7-1500", "PLC.Blocks.main_DB.SW2Down", 1)
SetData(SW2Down, "Local HMI", LB, 53, 1)


end macro_command