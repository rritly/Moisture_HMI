// 90 ms
macro_command main()

bool errMoisture = false
bool enMoistuere = false
bool err = false
float currMoisture = 0.0


GetDataEx(currMoisture, "Siemens S7-1200/S7-1500", DBDn, 130018, 1)
GetDataEx(err, "Siemens S7-1200/S7-1500", "PLC.Blocks.main_DB.disConnMoistUp", 1)
SetData(err, "Local HMI", LB, 170, 1)
enMoistuere = not err
SetData(enMoistuere, "Local HMI", LB, 169, 1)

if currMoisture < 0.1 then
    errMoisture = true
    currMoisture = 0.0
    SetData(errMoisture, "Local HMI", LB, 234, 1)
    SetData(currMoisture, "Local HMI", LW, 96, 1)
else if currMoisture > 19.9 then
    errMoisture = true
    currMoisture = 20.0
    SetData(errMoisture, "Local HMI", LB, 234, 1)
    SetData(currMoisture, "Local HMI", LW, 96, 1)
else
    errMoisture = false
    SetData(errMoisture, "Local HMI", LB, 234, 1)
    SetData(currMoisture, "Local HMI", LW, 96, 1)
end if


end macro_command