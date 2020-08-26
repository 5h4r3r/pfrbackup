#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Res_Fileversion=0.5.0.0
#AutoIt3Wrapper_Res_ProductName=Backup alpha v0.4
#AutoIt3Wrapper_Res_ProductVersion=0.5
#AutoIt3Wrapper_Res_CompanyName=DDC
#AutoIt3Wrapper_Res_Language=1049
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
#include "varlib.au3"
#include "funclib.au3"
_Main()

Func _Main()
; Вызов проверки
    If _ErorrsCheck() = False Then Exit
; Отрисовка трея   
    _TrayConfig()

; Цикл проверяет условия создания бекапа с определенной переодичностью
    If $backupDay = "X" Then
        If $backupHour = "X" Then
        ; Запуск в ручном
            _dbg("conf:manual")
        TrayTip($progname, "Бекап запущен!" & @CRLF _
             & "Текущая конфигурация: " & "Запуск в ручном режиме", 2, 1)
            sleep (10000)
        While 1
            ; Пустой цикл раз в час
            sleep(_TimeConv(60))
        WEnd
        Else
            ; Запуск в определенный час любого дня
            _dbg("conf:D=X H=$")
            TrayTip($progname, "Бекап запущен!" & @CRLF _
            & "Текущая конфигурация: " & "Запуск каждый день в " & $backupHour & " час", 2, 1)
           sleep (10000)
           While 1 
               $fDate = "" & @MDAY  & @MON  & @YEAR & "_" & @HOUR & "*"
               ; Проверка условий запуска бекапа
               If (@HOUR = $backupHour) And (FileExists($pBackupDir & "\" & $fDate) = 0) Then
                   _CreateBackup()
                   ; Очистка директорий
                   _CleanDir()
               EndIf 
               ; Время ожидания до запуска следующей проверки
               Sleep(_TimeConv(60))
            WEnd  
            EndIf
    Else
        If $backupHour = "X" Then
            ; Запуск в определенный день в любой час
            _dbg("conf:D=$ H=X")
            TrayTip($progname, "Бекап запущен!" & @CRLF _
             & "Текущая конфигурация: " & "Запуск " & $backupDay & " числа каждого месяца", 2, 1)
            sleep (10000)
            While 1 
                $fDate = "" & @MDAY  & @MON  & @YEAR & "_*"
                ; Проверка условий запуска бекапа
                If (@MDAY = $backupDay) And (FileExists($pBackupDir & "\" & $fDate) = 0) Then
                    _CreateBackup()
                    ; Очистка директорий
                    _CleanDir()
                EndIf 
                ; Время ожидания до запуска следующей проверки
                Sleep(_TimeConv(30))
             WEnd  
            Else
            ; Запуск в определенный день в определенный час
                _dbg("conf:D=$ H=$")
            TrayTip($progname, "Бекап запущен!" & @CRLF _
            & "Текущая конфигурация: " & "Запуск " & $backupDay & " числа каждого месяца в "& $backupHour & " час", 2, 1)
            sleep (10000)
        While 1
            $fDate = "" & @MDAY  & @MON  & @YEAR & "_" & @HOUR & "*"
            ; Проверка условий запуска бекапа
            If (@MDAY = $backupDay) And (@HOUR = $backupHour) And (FileExists($pBackupDir & "\" & $fDate) = 0) Then
                _CreateBackup()
                ; Очистка директорий
                _CleanDir()
            EndIf 
            ; Время ожидания до запуска следующей проверки 
            sleep(_TimeConv($CheckBackupTime))
         WEnd
         EndIf
    EndIf
    EndFunc

    ;If $backupDay = "X" Then
        ;If $backupHour = "X" Then
            ; Запуск в ручном
        ;Else
            ; Запуск в определенный час любого дня
    ;Else
        ;If $backupHour = "X" Then
            ; Запуск в определенный день в любой час
        ;Else    
            ; Запуск в определенный день в определенный час
        ;EndIf        