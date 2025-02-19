
macro_command main()
bool SW1 = false, SW2 = false, out = false

GetData(SW1, "Local HMI", LB, 52, 1)
GetData(SW2, "Local HMI", LB, 53, 1)

DELAY(40)

out = not (SW1 or SW2)

SetData(out, "Local HMI", LB, 45, 1)

end macro_command