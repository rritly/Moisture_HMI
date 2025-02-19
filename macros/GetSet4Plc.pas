//103 ms
macro_command main()

int distanceL2Up = 0
int distanceL2Down = 0


GetDataEx(distanceL2Up, "Siemens S7-1200/S7-1500", "PLC.Blocks.READ.upper.distanceL2", 1)
SetData(distanceL2Up, "Local HMI", LW, 82, 1)
GetDataEx(distanceL2Down, "Siemens S7-1200/S7-1500", "PLC.Blocks.READ.lower.distanceL2", 1)
SetData(distanceL2Down, "Local HMI", LW, 88, 1)


end macro_command