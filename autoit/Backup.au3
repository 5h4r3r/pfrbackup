#include "var.au3"
#include "FuncBU.au3"
; Вызов проверок
_ReadConfig()
_DirCheck()
_ErorrsDisplay()
;
; Настройка трея
;
    TraySetIcon('shell32.dll', 7)
    Opt("TrayOnEventMode", 1)
    Opt("GUIOnEventMode", 1)
    Opt("SendCapslockMode", 0)
    Opt("TrayMenuMode", 1 + 2)
    $trayCreateBackup = TrayCreateItem("Создать бекап")
    TrayItemSetOnEvent($trayCreateBackup, "_CreateBackup")
    TrayCreateItem("")
    $trayClean = TrayCreateMenu("Очистка")
    $trayCleanDir1 = TrayCreateItem("Удалить файлы в исходной директории", $trayClean)
    $trayCleanDir2 = TrayCreateItem("Удалить файлы в конечной директории", $trayClean)
    TrayItemSetOnEvent($trayCleanDir1, "_TrayDelete1")
    TrayItemSetOnEvent($trayCleanDir2, "_TrayDelete2")
    TrayCreateItem("")
    $aboutitem = TrayCreateItem("О программе")
    TrayItemSetOnEvent($aboutitem, "About")
    TrayCreateItem("")
    $exititem = TrayCreateItem("Выход")
    TrayItemSetOnEvent($exititem, "Exit1")
; 
; Цикл проверяет условия создания бекапа с определенной переодичностью
;
    If $backupDay = "X" Then
        ; Cообщение при запуске
        TrayTip($progname, "Бекап запущен!" & @CRLF _
             & "Текущая конфигурация: " & "Запуск в ручном режиме", 2, 1)
            sleep (10000)
        While 1
            ; Пустой цикл раз в час
            sleep (3600000)
        WEnd
    Else
        If $backupHour = "X" Then
            ; Cообщение при запуске
            TrayTip($progname, "Бекап запущен!" & @CRLF _
             & "Текущая конфигурация: " & "Запуск " & $backupDay & " числа каждого месяца", 2, 1)
            sleep (10000)
            While 1 
                $fDate = "" & @MDAY  & @MON  & @YEAR & "_*"
                ; Проверка условий запуска бекапа
                If (@MDAY = $backupDay) And (FileExists($pBackupDir & "\" & $fDate) = 0) Then
                    _CreateBackup()
                    ; Очистка директорий
                    If $cleanDir = "True" Then
                        _Delete($pFileDir)
                    EndIf
                EndIf 
                ; Время ожидания до запуска следующей проверки
                Sleep(3600000)
             WEnd  
            Else
            ; Cообщение при запуске
            TrayTip($progname, "Бекап запущен!" & @CRLF _
            & "Текущая конфигурация: " & "Запуск " & $backupDay & " числа каждого месяца в "& $backupHour & " час", 2, 1)
            sleep (10000)
        While 1
            $fDate = "" & @MDAY  & @MON  & @YEAR & "_" & @HOUR & "*"
            ; Проверка условий запуска бекапа
            If (@MDAY = $backupDay) And (@HOUR = $backupHour) And (FileExists($pBackupDir & "\" & $fDate) = 0) Then
                _CreateBackup()
                ; Очистка директорий
                If $cleanDir = "True" Then
                    _Delete($pFileDir)
                EndIf
            EndIf 
            ; Время ожидания до запуска следующей проверки 
            Sleep(_TimeConv($CheckBackupTime))
         WEnd
         EndIf
    EndIf