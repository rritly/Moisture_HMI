
macro_command main()

bool enAuto2_12 = false // переход на 15
bool enManual2_12 = false // переход на 17

bool enAuto1_15 = false // переход на 12
bool enManual1_15 = false // переход на 16

bool enAuto2_16 = false // переход на 15
bool enManual2_16 = false // переход на 17

bool enAuto1_17 = false  // переход на 12
bool enManual1_17 = false // переход на 16

bool mainToAuto1 = true, mainToManual1 = true, mainToAuto2 = true

unsigned char currScreen = 0
unsigned char SelMode = 0
unsigned char selectScreen = 0
unsigned char pass = 2

GetData(currScreen, "Local HMI", LW, 9050, 1)
GetData(SelMode, "Local HMI", LW, 94, 1)


select case SelMode
case 0
    enManual2_16 = true
    enManual1_17 = true
    mainToAuto1 = false
    mainToAuto2 = false
break
case 1
    enManual2_12 = true
    enAuto1_17 = true
    mainToAuto2 = false
    mainToManual1 = false
break
case 2
    enManual1_15 = true
    enAuto2_16 = true
    mainToAuto1 = false
    mainToManual1 = false
break
case 3
    enAuto2_12 = true
    enAuto1_15 = true
    mainToManual1 = false
    mainToAuto2 = false
break
end select



if currScreen == 12 and (SelMode == 0 or SelMode == 2) then 
    if  selectScreen == 16 then
        selectScreen = 18
    else if selectScreen <> 16 then
        selectScreen = 16
    else
    end if
else
end if
if currScreen == 15 and (SelMode == 0 or SelMode == 1) then 
    if  selectScreen == 17 then
        selectScreen = 18
    else if selectScreen <> 17 then
        selectScreen = 17
    else
    end if
else
end if


if currScreen == 16 and (SelMode == 1 or SelMode == 3) then 
    if  selectScreen == 12 then
        selectScreen = 18
    else if selectScreen <> 12 then
        selectScreen = 12
    else
    end if
else
end if
if currScreen == 17 and (SelMode == 2 or SelMode == 3) then 
    if  selectScreen == 15 then
        selectScreen = 18
    else if selectScreen <> 15 then
        selectScreen = 15
    else
    end if
else
end if



if (currScreen <> 11) then 
    pass = 3
else if currScreen == 11 then
    pass = 2
else
end if

SetData(enAuto2_12, "Local HMI", LB, 80, 1)
SetData(enManual2_12, "Local HMI", LB, 81, 1)

SetData(enAuto1_15, "Local HMI", LB, 82, 1)
SetData(enManual1_15, "Local HMI", LB, 83, 1)

SetData(enAuto2_16, "Local HMI", LB, 85, 1)
SetData(enManual2_16, "Local HMI", LB, 84, 1)

SetData(enAuto1_17, "Local HMI", LB, 87, 1)
SetData(enManual1_17, "Local HMI", LB, 86, 1)

SetData(mainToAuto1, "Local HMI", LB, 88, 1)
SetData(mainToManual1, "Local HMI", LB, 89, 1)
SetData(mainToAuto2, "Local HMI", LB, 90, 1)

SetData(selectScreen, "Local HMI", LW, 10, 1)

SetData(pass, "Local HMI", LW, 8950, 1)

end macro_command