
macro_command main()

//Пуск макроса
bool macro = true
bool macroDelay = false
bool macroRaise = false

// Ожидание перед запуском программы
bool pause, pauseRaise = false, pauseFall = false

// Сигнал работы влагомера
bool enable = false

// Пуск программы после паузы
bool run = false, runRise = false

// Фронт сигнала работы влагомера
bool enableRaise = false

// Спад сигнала работы влагомера
bool enableFall = false, enableFall2 = false, enableFall3 = false

// точка на вертикальной оси
bool position0 = false, position1 = false, position2 = false, position3 = false, position4 = false, position5 = false, position6 = false 

// точка на вертикальной оси, фронт
bool  position0Raise = false, position1Raise = false, position2Raise = false, position3Raise = false, position4Raise = false, position5Raise = false, position6Raise = false

// точка на вертикальной оси, спад
bool position0Fall = false, position1Fall = false, position2Fall = false, position3Fall = false, position4Fall = false, position5Fall = false, position6Fall = false

// линия среза графика
bool graf0 = false, graf1  = false, graf2 = false, graf3 = false, graf4 = false, graf5  = false, graf6 = false, graf7  = false, graf8 = false, graf9 = false, graf10 = false, graf11 = false
bool graf12 = false, graf13 = false, graf14 = false, graf15 = false, graf16 = false, graf17 = false, graf18 = false, graf19 = false, graf20 = false, graf21 = false, graf22 = false, graf23 = false

// линия среза графика - фронт сигнала
bool graf0Raise = false, graf1Raise  = false, graf2Raise = false, graf3Raise = false, graf4Raise = false, graf5Raise  = false, graf6Raise = false, graf7Raise  = false, graf8Raise = false, graf9Raise = false, graf10Raise = false, graf11Raise = false
bool graf12Raise = false, graf13Raise = false, graf14Raise = false, graf15Raise = false, graf16Raise = false, graf17Raise = false, graf18Raise = false, graf19Raise = false, graf20Raise = false, graf21Raise = false, graf22Raise = false, graf23Raise = false

// линия среза графика - спад сигнала
bool graf0Fall = false, graf1Fall  = false, graf2Fall = false, graf3Fall = false, graf4Fall = false, graf5Fall  = false, graf6Fall = false, graf7Fall  = false, graf8Fall = false, graf9Fall = false, graf10Fall = false, graf11Fall = false
bool graf12Fall = false, graf13Fall = false, graf14Fall = false, graf15Fall = false, graf16Fall = false, graf17Fall = false, graf18Fall = false, graf19Fall = false, graf20Fall = false,  graf21Fall = false, graf22Fall = false, graf23Fall = false

// сигнал показа числа на графике
bool moisture0, moisture1, moisture2, moisture3, moisture4, moisture5, moisture6, moisture7, moisture8, moisture9, moisture10, moisture11, moisture12, moisture13, moisture14, moisture15, moisture16, moisture17, moisture18, moisture19, moisture20, moisture21, moisture22, moisture23

// Отсутствие достоверной влажности
bool NotMoisture0, NotMoisture1, NotMoisture2, NotMoisture3, NotMoisture4, NotMoisture5, NotMoisture6, NotMoisture7, NotMoisture8, NotMoisture9, NotMoisture10, NotMoisture11, NotMoisture12, NotMoisture13, NotMoisture14, NotMoisture15, NotMoisture16, NotMoisture17, NotMoisture18, NotMoisture19, NotMoisture20, NotMoisture21, NotMoisture22, NotMoisture23

// Отсутствие достоверной влажности
bool errMoisture = false, errMoistureRaise = false, errMoistureFall = false

// Направление движения влагомера (1=обратно)
bool direction = false

// Пройдена вся ширина листа. 4 переменных - 4 прохода
bool scan0, scan1, scan2, scan3

// Флаг появления всех точек на графике
bool allMoisture = false

// Статус работы влагомера(3=работа)
unsigned char status = 0

// Текущая позиция(0 - 7)
unsigned char position = 0

// Положение текущей точки по горизонтальной оси
unsigned char countPositionAll, countPosition0, countPosition1, countPosition2, countPosition3

// Текущая позиция в обратном порядке(7 - 0)
unsigned char reversPosition = 0

// Ширина листа, мм
unsigned short constDistance = 0

// Текущее положение влагомера, мм
unsigned short currDistance = 0

// 7 точек по вертикальной оси, мм
unsigned short pointDistance0, pointDistance1, pointDistance2, pointDistance3, pointDistance4, pointDistance5

// 6 точек по вертикальной оси, мм
unsigned short pointDistance00, pointDistance11, pointDistance22, pointDistance33, pointDistance44, pointDistance55 = 0

// Текущая влажность
float currMoisture = 0.0

// Задержка после пуска макроса
macroDelay = TON0(macro, 55)

// фронт сигнала пуска макроса
macroRaise = rise32(macroDelay)

// Берем переменные из контроллера
GetData(status, "Local HMI", LW, 86, 1)
GetData(constDistance, "Local HMI", LW, 88, 1)
GetData(currDistance, "Local HMI", LW, 90, 1)
GetData(currMoisture, "Local HMI", LW, 98, 1)

//Взводим enable
if status == 3 then
    enable = true
else
end if

//Выход влажности за диапазон 0 - 20%
if currMoisture < 0.1 or currMoisture > 19.9 then
    errMoisture = true
else
end if

//Триггер на случай если панель была включена во время работы увлажнителя, чтобы произошла инициализация
if macroRaise and currDistance <> 0 then
    pause = true
else
end if

//Сброс триггера паузы после инициализации (дистанция меньше 60мм)
if pause  and currDistance < 60 then
    pause = false
else
end if

//Вывод строки об инициализации графика
pauseRaise = rise33(pause)
pauseFall = fall33(pause)
if pauseRaise or pauseFall then
    SetData(pause, "Local HMI", LB, 435, 1)
else
end if

//Спад сигнала enable
enableFall = fall31(enable)
//Задержанный спад сигнала enable
enableFall2 = fall32(enableFall)
enableFall3 = fall34(enableFall2)
//Фронт сигнала enable
enableRaise = rise34(enable)

//Сброс точек на графике
if enableFall3  then 
    moisture0 = false
    moisture1 = false
    moisture2 = false
    moisture3 = false
    moisture4 = false
    moisture5 = false
    moisture6 = false
    moisture7 = false
    moisture8 = false
    moisture9 = false
    moisture10 = false
    moisture11 = false
    moisture12 = false
    moisture13 = false
    moisture14 = false
    moisture15 = false
    moisture16 = false
    moisture17 = false
    moisture18 = false
    moisture19 = false
    moisture20 = false
    moisture21 = false
    moisture22 = false
    moisture23 = false
    Notmoisture0 = false
    SetData(Notmoisture0, "Local HMI", LB, 410, 1)
    Notmoisture1 = false
    SetData(Notmoisture0, "Local HMI", LB, 411, 1)
    Notmoisture2 = false
    SetData(Notmoisture0, "Local HMI", LB, 412, 1)
    Notmoisture3 = false
    SetData(Notmoisture0, "Local HMI", LB, 413, 1)
    Notmoisture4 = false
    SetData(Notmoisture0, "Local HMI", LB, 414, 1)
    Notmoisture5 = false
    SetData(Notmoisture0, "Local HMI", LB, 415, 1)
    Notmoisture6 = false
    SetData(Notmoisture0, "Local HMI", LB, 416, 1)
    Notmoisture7 = false
    SetData(Notmoisture0, "Local HMI", LB, 417, 1)
    Notmoisture8 = false
    SetData(Notmoisture0, "Local HMI", LB, 418, 1)
    Notmoisture9 = false
    SetData(Notmoisture0, "Local HMI", LB, 419, 1)
    Notmoisture10 = false
    SetData(Notmoisture0, "Local HMI", LB, 420, 1)
    Notmoisture11 = false
    SetData(Notmoisture0, "Local HMI", LB, 421, 1)
    Notmoisture12 = false
    SetData(Notmoisture0, "Local HMI", LB, 422, 1)
    Notmoisture13 = false
    SetData(Notmoisture0, "Local HMI", LB, 423, 1)
    Notmoisture14 = false
    SetData(Notmoisture0, "Local HMI", LB, 424, 1)
    Notmoisture15 = false
    SetData(Notmoisture0, "Local HMI", LB, 425, 1)
    Notmoisture16 = false
    SetData(Notmoisture0, "Local HMI", LB, 426, 1)
    Notmoisture17 = false
    SetData(Notmoisture0, "Local HMI", LB, 427, 1)
    Notmoisture18 = false
    SetData(Notmoisture0, "Local HMI", LB, 428, 1)
    Notmoisture19 = false
    SetData(Notmoisture0, "Local HMI", LB, 429, 1)
    Notmoisture20 = false
    SetData(Notmoisture0, "Local HMI", LB, 430, 1)
    Notmoisture21 = false
    SetData(Notmoisture0, "Local HMI", LB, 431, 1)
    Notmoisture22 = false
    SetData(Notmoisture0, "Local HMI", LB, 432, 1)
    Notmoisture23 = false
    SetData(Notmoisture0, "Local HMI", LB, 433, 1)
else
end if

//Разбивка установленной ширины хода влагомера на отрезки. И выполнение по условию один раз.
if enableRaise or macroRaise then
    pointDistance0 = constDistance / 7 * 6
    pointDistance1 = constDistance / 7 * 5
    pointDistance2 = constDistance / 7 * 4
    pointDistance3 = constDistance / 7 * 3 
    pointDistance4 = constDistance / 7 * 2
    pointDistance5 = constDistance / 7
else
end if

//Условие запуска всей программы
if macro and macroDelay and not pause then
//Задаем номер позиции исходя из текущего положения влагомера
    if currDistance < pointDistance5 then
        position = 1
    else
    end if
    if  currDistance > pointDistance5 then
        position = 2
    else
    end if
    if currDistance > pointDistance4 then
        position = 3
    else
    end if
    if currDistance > pointDistance3 then
        position = 4
    else
    end if
    if  currDistance > pointDistance2 then
        position = 5
    else
    end if
    if currDistance > pointDistance1 then
        position = 6
    else
    end if
    if currDistance > pointDistance0  then
        position = 7
    else
    end if

    //Определяем направление по росту/спаду числа(true - обратное)
    direction = numDirection(currDistance, not enable)
    reversPosition = 7 - position

    //сброс накопленной истории
    if scan0 and scan1 and scan2 and scan3 or not enable then
        countPosition0 = 0
        countPosition1 = 0
        countPosition2 = 0
        countPosition3 = 0
        scan0 = false
        scan1 = false
        scan2 = false
        scan3 = false
    else
    end if

    //Первый проход влагомера
    if not scan1 and not scan0 then
        countPosition0 = position
        if  direction and (position > 4) then
            scan0 = true
        else
        end if
    else
    end if

    //Второй проход
    if scan0 and not scan1 then
        countPosition1 = reversPosition
        if not direction then
            scan1 = true
        else
        end if
    else
    end if

    //Третий проход
    if scan1 and not scan2 then
        countPosition2 = position - 1
        if  direction  then
            scan2 = true
        else
        end if
    else
    end if

    //Четвертый проход
    if scan2 and not scan3 then
        countPosition3 = reversPosition
        if  not direction or (countPosition3 == 6) then
            scan3 = true
        else
        end if
    else
    end if

    //Текущее положение по горизонтальной оси (от 0 до 24)
    countPositionAll = countPosition0 + countPosition1 + countPosition2 + countPosition3
    if not enable then
        countPositionAll = 0
        position = 0
    else
    end if

    //Извлечение отдельных битов из числа текущей позиции (ось Y)
    select case position
        case 0 
            position0 = false
        break
        case 1 
            position0 = true
        break
        case 2
            position1 = true
        break
        case 3
            position2 = true
        break
        case 4 
            position3 = true
        break
        case 5
            position4 = true
        break
        case 6
            position5 = true
        break
        case 7
            position6 = true
        break
    end select


    // Извлечение отдельных битов из числа текущей позиции (ось X)
    select case countPositionAll
    case 0 
        graf0 = false
    break
    case 1 
        graf0 = true
    break
    case 2
        graf1 = true
    break
    case 3
        graf2 = true
    break
    case 4 
        graf3 = true
    break
    case 5
        graf4 = true
    break
    case 6
        graf5 = true
    break
    case 7 
        graf6 = true
    break
    case 8
        graf7 = true
    break
    case 9
        graf8 = true
    break
    case 10 
        graf9 = true
    break
    case 11
        graf10 = true
    break
    case 12
        graf11 = true
    break
    case 13 
        graf12 = true
    break
    case 14
        graf13 = true
    break
    case 15
        graf14 = true
    break
    case 16 
        graf15 = true
    break
    case 17
        graf16 = true
    break
    case 18
        graf17 = true
    break
    case 19 
        graf18 = true
    break
    case 20
        graf19 = true
    break
    case 21
        graf20 = true
    break
    case 22 
        graf21 = true
    break
    case 23
        graf22 = true
    break
    case 24
        graf23 = true
    break
    end select 

    // Извлечение фронта/спада из сигналов позиции (ось Y и X)
    graf0Raise = rise0(graf0)
    graf0Fall = fall0(graf0)
    graf1Raise = rise1(graf1)
    graf1Fall = fall1(graf1)
    graf2Raise = rise2(graf2)
    graf2Fall = fall2(graf2)
    graf3Raise = rise3(graf3)
    graf3Fall = fall3(graf3)
    graf4Raise = rise4(graf4)
    graf4Fall = fall4(graf4)
    graf5Raise = rise5(graf5)
    graf5Fall = fall5(graf5)
    graf6Raise = rise6(graf6)
    graf6Fall = fall6(graf6)
    graf7Raise = rise7(graf7)
    graf7Fall = fall7(graf7)
    graf8Raise = rise8(graf8)
    graf8Fall = fall8(graf8)
    graf9Raise = rise9(graf9)
    graf9Fall = fall9(graf9)
    graf10Raise = rise10(graf10)
    graf10Fall = fall10(graf10)
    graf11Raise = rise11(graf11)
    graf11Fall = fall11(graf11)
    graf12Raise = rise12(graf12)
    graf12Fall = fall12(graf12)
    graf13Raise = rise13(graf13)
    graf13Fall = fall13(graf13)
    graf14Raise = rise14(graf14)
    graf14Fall = fall14(graf14)
    graf15Raise = rise15(graf15)
    graf15Fall = fall15(graf15)
    graf16Raise = rise16(graf16)
    graf16Fall = fall16(graf16)
    graf17Raise = rise17(graf17)
    graf17Fall = fall17(graf17)
    graf18Raise = rise18(graf18)
    graf18Fall = fall18(graf18)
    graf19Raise = rise19(graf19)
    graf19Fall = fall19(graf19)
    graf20Raise = rise20(graf20)
    graf20Fall = fall20(graf20)
    graf21Raise = rise21(graf21)
    graf21Fall = fall21(graf21)
    graf22Raise = rise22(graf22)
    graf22Fall = fall22(graf22)
    graf23Raise = rise23(graf23)
    graf23Fall = fall23(graf23)
    position0Raise = rise24(position0)
    position0Fall = fall24(position0)
    position1Raise = rise25(position1)
    position1Fall = fall25(position1)
    position2Raise = rise26(position2)
    position2Fall = fall26(position2)
    position3Raise = rise27(position3)
    position3Fall = fall27(position3)
    position4Raise = rise28(position4)
    position4Fall = fall28(position4)
    position5Raise = rise29(position5)
    position5Fall = fall29(position5)
    position6Raise = rise30(position6)
    position6Fall = fall30(position6)

    // Передача в память по факту изменения переменной (ось Y)
    if position0Raise or position0Fall or enableFall2  then
        SetData(position0, "Local HMI", LB, 342, 1)
    else
    end if
    if position1Raise or position1Fall or enableFall2  then
        SetData(position1, "Local HMI", LB, 343, 1)
    else
    end if
    if position2Raise or position2Fall or enableFall2  then
        SetData(position2, "Local HMI", LB, 344, 1)
    else
    end if
    if position3Raise or position3Fall or enableFall2  then
        SetData(position3, "Local HMI", LB, 345, 1)
    else
    end if
    if position4Raise or position4Fall or enableFall2  then
        SetData(position4, "Local HMI", LB, 346, 1)
    else
    end if
    if position5Raise or position5Fall or enableFall2  then
        SetData(position5, "Local HMI", LB, 347, 1)
    else
    end if
    if position6Raise or position6Fall or enableFall2  then
        SetData(position6, "Local HMI", LB, 348, 1)
    else
    end if

    // Передача в память по факту изменения переменной (линия среза оси Х)
    if graf0Raise or graf0Fall or enableFall2  then
        SetData(graf0, "Local HMI", LB, 300, 1)
    else
    end if
    if graf1Raise or graf1Fall  then
        SetData(graf1, "Local HMI", LB, 301, 1)
    else
    end if
    if graf2Raise or graf2Fall  then
        SetData(graf2, "Local HMI", LB, 302, 1)
    else
    end if
    if graf3Raise or graf3Fall  then
        SetData(graf3, "Local HMI", LB, 303, 1)
    else
    end if
    if graf4Raise or graf4Fall then
        SetData(graf4, "Local HMI", LB, 304, 1)
    else
    end if
    if graf5Raise or graf5Fall  then
        SetData(graf5, "Local HMI", LB, 305, 1)
    else
    end if
    if graf6Raise or graf6Fall  then
        SetData(graf6, "Local HMI", LB, 306, 1)
    else
    end if
    if graf7Raise or graf7Fall  then
        SetData(graf7, "Local HMI", LB, 307, 1)
    else
    end if
    if graf8Raise or graf8Fall  then
        SetData(graf8, "Local HMI", LB, 308, 1)
    else
    end if
    if graf9Raise or graf9Fall  then
        SetData(graf9, "Local HMI", LB, 309, 1)
    else
    end if
    if graf10Raise or graf10Fall  then
        SetData(graf10, "Local HMI", LB, 310, 1)
    else
    end if
    if graf11Raise or graf11Fall  then
        SetData(graf11, "Local HMI", LB, 311, 1)
    else
    end if
    if graf12Raise or graf12Fall  then
        SetData(graf12, "Local HMI", LB, 312, 1)
    else
    end if
    if graf13Raise or graf13Fall  then
        SetData(graf13, "Local HMI", LB, 313, 1)
    else
    end if
    if graf14Raise or graf14Fall  then
        SetData(graf14, "Local HMI", LB, 314, 1)
    else
    end if
    if graf15Raise or graf15Fall  then
        SetData(graf15, "Local HMI", LB, 315, 1)
    else
    end if
    if graf16Raise or graf16Fall  then
        SetData(graf16, "Local HMI", LB, 316, 1)
    else
    end if
    if graf17Raise or graf17Fall  then
        SetData(graf17, "Local HMI", LB, 317, 1)
    else
    end if
    if graf18Raise or graf18Fall  then
        SetData(graf18, "Local HMI", LB, 318, 1)
    else
    end if
    if graf19Raise or graf19Fall  then
        SetData(graf19, "Local HMI", LB, 319, 1)
    else
    end if
    if graf20Raise or graf20Fall  then
        SetData(graf20, "Local HMI", LB, 320, 1)
    else
    end if
    if graf21Raise or graf21Fall  then
        SetData(graf21, "Local HMI", LB, 321, 1)
    else
    end if
    if graf22Raise or graf22Fall  then
        SetData(graf22, "Local HMI", LB, 322, 1)
    else
    end if
    if graf23Raise or graf23Fall then
        SetData(graf23, "Local HMI", LB, 323, 1)
    else
    end if

    // Все точки на графике отображены. Нужно для прекращения вызова функций записи.
    allMoisture = enable and moisture0 and moisture1 and moisture2 and moisture3 and moisture4 and moisture5 and moisture6 and moisture0 and moisture7 and moisture8 and moisture9 and moisture10 and moisture11 and moisture12 and moisture13 and moisture14 and moisture15 and moisture16 and moisture17 and moisture18 and moisture19 and moisture20 and moisture21 and moisture22 and moisture23

    // Передача в память по факту изменения переменной оси Y.
    if graf0Raise or enableFall2 then
        // Если нет влажности, то показ серого прямоугольника
        if errMoisture or NotMoisture0 then
            SetData(errMoisture, "Local HMI", LB, 410, 1)
            NotMoisture0 = errMoisture
        else
        end if
        // Если влажность есть, то запись влажности в точку на графике
        if not errMoisture and enable then
            SetData(currMoisture, "Local HMI", LW, 200, 1)
            moisture0 = true
        else
        end if
        // Запись бита, для показа окошка с числом влажности на графике. Если все точки записаны, то прекращение записи.
        if not allMoisture then 
            SetData(graf0, "Local HMI", LB, 371, 1)
        else
        end if
    else
    end if
    if graf1Raise or enableFall2 then
        if errMoisture or NotMoisture1 then
            SetData(errMoisture, "Local HMI", LB, 411, 1)
            NotMoisture1 = errMoisture
        else
        end if
        if not errMoisture and enable then
            SetData(currMoisture, "Local HMI", LW, 202, 1)
            moisture1 = true
        else
        end if
        if not allMoisture then 
            SetData(graf1, "Local HMI", LB, 372, 1)
        else
        end if
    else
    end if
    if graf2Raise or enableFall2 then
        if errMoisture or NotMoisture2 then
            SetData(errMoisture, "Local HMI", LB, 412, 1)
            NotMoisture2 = errMoisture
        else
        end if
        if not errMoisture and enable then
            SetData(currMoisture, "Local HMI", LW, 204, 1)
            moisture2 = true
        else
        end if
        if not allMoisture then 
            SetData(graf2, "Local HMI", LB, 373, 1)
        else
        end if
    else
    end if
    if graf3Raise or enableFall2 then
        if errMoisture or NotMoisture3 then
            SetData(errMoisture, "Local HMI", LB, 413, 1)
            NotMoisture3 = errMoisture
        else
        end if
        if not errMoisture and enable then
            SetData(currMoisture, "Local HMI", LW, 206, 1)
            moisture3 = true
        else
        end if
        if not allMoisture then 
            SetData(graf3, "Local HMI", LB, 374, 1)
        else
        end if
    else
    end if
    if graf4Raise or enableFall2 then
        if errMoisture or NotMoisture4 then
            SetData(errMoisture, "Local HMI", LB, 414, 1)
            NotMoisture4 = errMoisture
        else
        end if
        if not errMoisture and enable then
            SetData(currMoisture, "Local HMI", LW, 208, 1)
            moisture4 = true
        else
        end if
        if not allMoisture then 
            SetData(graf4, "Local HMI", LB, 375, 1)
        else
        end if
    else
    end if
    if graf5Raise or enableFall2 then
        if errMoisture or NotMoisture5 then
            SetData(errMoisture, "Local HMI", LB, 415, 1)
            NotMoisture5 = errMoisture
        else
        end if
        if not errMoisture and enable then
            SetData(currMoisture, "Local HMI", LW, 210, 1)
            moisture5 = true
        else
        end if
        if not allMoisture then 
            SetData(graf5, "Local HMI", LB, 376, 1)
        else
        end if
    else
    end if
    if graf6Raise or enableFall2 then
        if errMoisture or NotMoisture6 then
            SetData(errMoisture, "Local HMI", LB, 416, 1)
            NotMoisture6 = errMoisture
        else
        end if
        if not errMoisture and enable then
            SetData(currMoisture, "Local HMI", LW, 212, 1)
            moisture6 = true
        else
        end if
        if not allMoisture then 
            SetData(graf6, "Local HMI", LB, 377, 1)
        else
        end if
    else
    end if
    if graf7Raise or enableFall2 then
        if errMoisture or NotMoisture7 then
            SetData(errMoisture, "Local HMI", LB, 417, 1)
            NotMoisture7 = errMoisture
        else
        end if
        if not errMoisture and enable then
            SetData(currMoisture, "Local HMI", LW, 214, 1)
            moisture7 = true
        else
        end if
        if not allMoisture then 
            SetData(graf7, "Local HMI", LB, 378, 1)
        else
        end if
    else
    end if
    if graf8Raise or enableFall2 then
        if errMoisture or NotMoisture8 then
            SetData(errMoisture, "Local HMI", LB, 418, 1)
            NotMoisture8 = errMoisture
        else
        end if
        if not errMoisture and enable then
            SetData(currMoisture, "Local HMI", LW, 216, 1)
            moisture8 = true
        else
        end if
        if not allMoisture then 
            SetData(graf8, "Local HMI", LB, 379, 1)
        else
        end if
    else
    end if
    if graf9Raise or enableFall2 then
        if errMoisture or NotMoisture9 then
            SetData(errMoisture, "Local HMI", LB, 419, 1)
            NotMoisture9 = errMoisture
        else
        end if
        if not errMoisture and enable then
            SetData(currMoisture, "Local HMI", LW, 218, 1)
            moisture9 = true
        else
        end if
        if not allMoisture then 
            SetData(graf9, "Local HMI", LB, 380, 1)
        else
        end if
    else
    end if
    if graf10Raise or enableFall2 then
        if errMoisture or NotMoisture10 then
            SetData(errMoisture, "Local HMI", LB, 420, 1)
            NotMoisture10 = errMoisture
        else
        end if
        if not errMoisture and enable then
            SetData(currMoisture, "Local HMI", LW, 220, 1)
            moisture10 = true
        else
        end if
        if not allMoisture then 
            SetData(graf10, "Local HMI", LB, 381, 1)
        else
        end if
    else
    end if
    if graf11Raise or enableFall2 then
        if errMoisture or NotMoisture11 then
            SetData(errMoisture, "Local HMI", LB, 421, 1)
            NotMoisture11 = errMoisture
        else
        end if
        if not errMoisture and enable then
            SetData(currMoisture, "Local HMI", LW, 222, 1)
            moisture11 = true
        else
        end if
        if not allMoisture then 
            SetData(graf11, "Local HMI", LB, 382, 1)
        else
        end if
    else
    end if
    if graf12Raise or enableFall2 then
        if errMoisture or NotMoisture12 then
            SetData(errMoisture, "Local HMI", LB, 422, 1)
            NotMoisture12 = errMoisture
        else
        end if
        if not errMoisture and enable then
            SetData(currMoisture, "Local HMI", LW, 224, 1)
            moisture12 = true
        else
        end if
        if not allMoisture then 
            SetData(graf12, "Local HMI", LB, 383, 1)
        else
        end if
    else
    end if
    if graf13Raise or enableFall2 then
        if errMoisture or NotMoisture13 then
            SetData(errMoisture, "Local HMI", LB, 423, 1)
            NotMoisture13 = errMoisture
        else
        end if
        if not errMoisture and enable then
            SetData(currMoisture, "Local HMI", LW, 226, 1)
            moisture13 = true
        else
        end if
        if not allMoisture then 
            SetData(graf13, "Local HMI", LB, 384, 1)
        else
        end if
    else
    end if
    if graf14Raise or enableFall2 then
        if errMoisture or NotMoisture14 then
            SetData(errMoisture, "Local HMI", LB, 424, 1)
            NotMoisture14 = errMoisture
        else
        end if
        if not errMoisture and enable then
            SetData(currMoisture, "Local HMI", LW, 228, 1)
            moisture14 = true
        else
        end if
        if not allMoisture then 
            SetData(graf14, "Local HMI", LB, 385, 1)
        else
        end if
    else
    end if
    if graf15Raise or enableFall2 then
        if errMoisture or NotMoisture15 then
            SetData(errMoisture, "Local HMI", LB, 425, 1)
            NotMoisture15 = errMoisture
        else
        end if
        if not errMoisture and enable then
            SetData(currMoisture, "Local HMI", LW, 230, 1)
            moisture15 = true
        else
        end if
        if not allMoisture then 
            SetData(graf15, "Local HMI", LB, 386, 1)
        else
        end if
    else
    end if
    if graf16Raise or enableFall2 then
        if errMoisture or NotMoisture16 then
            SetData(errMoisture, "Local HMI", LB, 426, 1)
            NotMoisture16 = errMoisture
        else
        end if
        if not errMoisture and enable then
            SetData(currMoisture, "Local HMI", LW, 232, 1)
            moisture16 = true
        else
        end if
        if not allMoisture then 
            SetData(graf16, "Local HMI", LB, 387, 1)
        else
        end if
    else
    end if
    if graf17Raise or enableFall2 then
        if errMoisture or NotMoisture17 then
            SetData(errMoisture, "Local HMI", LB, 427, 1)
            NotMoisture17 = errMoisture
        else
        end if
        if not errMoisture and enable then
            SetData(currMoisture, "Local HMI", LW, 234, 1)
            moisture17 = true
        else
        end if
        if not allMoisture then 
            SetData(graf17, "Local HMI", LB, 388, 1)
        else
        end if
    else
    end if
    if graf18Raise or enableFall2 then
        if errMoisture or NotMoisture18 then
            SetData(errMoisture, "Local HMI", LB, 428, 1)
            NotMoisture18 = errMoisture
        else
        end if
        if not errMoisture and enable then
            SetData(currMoisture, "Local HMI", LW, 236, 1)
            moisture18 = true
        else
        end if
        if not allMoisture then 
            SetData(graf18, "Local HMI", LB, 389, 1)
        else
        end if
    else
    end if
    if graf19Raise or enableFall2 then
        if errMoisture or NotMoisture19 then
            SetData(errMoisture, "Local HMI", LB, 429, 1)
            NotMoisture19 = errMoisture
        else
        end if
        if not errMoisture and enable then
            SetData(currMoisture, "Local HMI", LW, 238, 1)
            moisture19 = true
        else
        end if
        if not allMoisture then 
            SetData(graf19, "Local HMI", LB, 390, 1)
        else
        end if
    else
    end if
    if graf20Raise or enableFall2 then
        if errMoisture or NotMoisture20 then
            SetData(errMoisture, "Local HMI", LB, 430, 1)
            NotMoisture20 = errMoisture
        else
        end if
        if not errMoisture and enable then
            SetData(currMoisture, "Local HMI", LW, 240, 1)
            moisture20 = true
        else
        end if
        if not allMoisture then 
            SetData(graf20, "Local HMI", LB, 391, 1)
        else
        end if
    else
    end if
    if graf21Raise or enableFall2 then
        if errMoisture or NotMoisture21 then
            SetData(errMoisture, "Local HMI", LB, 431, 1)
            NotMoisture21 = errMoisture
        else
        end if
        if not errMoisture and enable then
            SetData(currMoisture, "Local HMI", LW, 242, 1)
            moisture21 = true
        else
        end if
        if not allMoisture then 
            SetData(graf21, "Local HMI", LB, 392, 1)
        else
        end if
    else
    end if
    if graf22Raise or enableFall2 then
        if errMoisture or NotMoisture22 then
            SetData(errMoisture, "Local HMI", LB, 432, 1)
            NotMoisture22 = errMoisture
        else
        end if
        if not errMoisture and enable then
            SetData(currMoisture, "Local HMI", LW, 244, 1)
            moisture22 = true
        else
        end if

        if not allMoisture then 
            SetData(graf22, "Local HMI", LB, 393, 1)
        else
        end if
    else
    end if
    if graf23Raise or enableFall2 then
        if errMoisture or NotMoisture23 then
            SetData(errMoisture, "Local HMI", LB, 433, 1)
            NotMoisture23 = errMoisture
        else
        end if
        if not errMoisture and enable then
            SetData(currMoisture, "Local HMI", LW, 246, 1)
            moisture23 = true
        else
        end if
        if not allMoisture then 
            SetData(graf23, "Local HMI", LB, 394, 1)
        else
        end if
    else
    end if
else
end if

// Однократное вычислени интервалов между позициями чтобы показать точки пройденного пути (ось Y)
if enableRaise or macroRaise then
    pointDistance00 = constDistance / 6 * 5
    pointDistance11 = constDistance / 6 * 4
    pointDistance22 = constDistance / 6 * 3 
    pointDistance33 = constDistance / 6 * 2
    pointDistance44 = constDistance / 6
else
end if

// Передача вычисленных чисел точек пройденного пути в память
if enableRaise or macroRaise then
    SetData(pointDistance55, "Local HMI", LW, 380, 1)
    SetData(pointDistance44, "Local HMI", LW, 382, 1)
    SetData(pointDistance33, "Local HMI", LW, 384, 1)
    SetData(pointDistance22, "Local HMI", LW, 386, 1)
    SetData(pointDistance11, "Local HMI", LW, 388, 1)
    SetData(pointDistance00, "Local HMI", LW, 390, 1)
    SetData(constDistance, "Local HMI", LW, 392, 1)
else
end if

end macro_command
