// 62ms
macro_command main()

int currDistance1Up = 0

GetDataEx(currDistance1Up, "Siemens S7-1200/S7-1500", "PLC.Blocks.READ.upper.currDistance", 1)
SetData(currDistance1Up, "Local HMI", LW, 84, 1)


end macro_command