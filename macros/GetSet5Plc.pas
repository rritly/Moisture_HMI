// 146ms
macro_command main()

unsigned char SelMode = 0
bool SW2Up = false
bool SW1Down = false


GetDataEx(SelMode, "Siemens S7-1200/S7-1500", "PLC.Blocks.main_DB.modes", 1)
SetData(SelMode, "Local HMI", LW, 94, 1)

GetDataEx(SW2Up, "Siemens S7-1200/S7-1500", "PLC.Blocks.main_DB.SW2Up", 1)
SetData(SW2Up, "Local HMI", LB, 51, 1)

GetDataEx(SW1Down, "Siemens S7-1200/S7-1500", "PLC.Blocks.main_DB.SW1Down", 1)
SetData(SW1Down, "Local HMI", LB, 52, 1)

end macro_command