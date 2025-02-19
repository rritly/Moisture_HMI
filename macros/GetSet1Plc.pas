// 62 ms
macro_command main()

int currDistance1Down = 0

GetDataEx(currDistance1Down, "Siemens S7-1200/S7-1500", "PLC.Blocks.READ.lower.currDistance", 1)
SetData(currDistance1Down, "Local HMI", LW, 90, 1)

end macro_command