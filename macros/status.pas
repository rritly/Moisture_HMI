
macro_command main()

short status1 = 0
short status2 = 0
bool waiting1 = false, initia1 = false, run1 = false, faultSP1 = false, onSW1 = false
bool waiting2 = false, initia2 = false, run2 = false, faultSP2 = false, onSW2 = false
bool emergency = false
bool generator0 = false
short allStatus = 0


GetData(status1, "Local HMI", LW, 80, 1)
GetData(status2, "Local HMI", LW, 86, 1)
GetData(allStatus, "Local HMI", LW, 92, 1)

DELAY(40)

if allStatus == 1 then
	emergency = true
else
end if

generator0 = TOFON0(emergency, 6)

select case status1
case 0
	waiting1 = true
	break
case 1 
	onSW1 = true
	break
case 2
	initia1 = true
	break
case 3 
	run1 = true
	break
case 4
	faultSP1 = true
	break
end select

select case status2
case 0
	waiting2 = true
	break
case 1 
	onSW2 = true
	break
case 2
	initia2 = true
	break
case 3 
	run2 = true
	break
case 4
	faultSP2 = true
	break
end select

SetData(waiting1, "Local HMI", LB, 60, 1)
SetData(onSW1, "Local HMI", LB, 61, 1)
SetData(initia1, "Local HMI", LB, 62, 1)
SetData(run1, "Local HMI", LB, 63, 1)
SetData(faultSP1, "Local HMI", LB, 64, 1)
SetData(waiting2, "Local HMI", LB, 65, 1)
SetData(onSW2, "Local HMI", LB, 66, 1)
SetData(initia2, "Local HMI", LB, 67, 1)
SetData(run2, "Local HMI", LB, 68, 1)
SetData(faultSP2, "Local HMI", LB, 69, 1)
SetData(generator0, "Local HMI", LB, 70, 1)

end macro_command