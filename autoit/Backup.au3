#include "errorcheck.au3"
; Настройка трея
    TraySetIcon('shell32.dll', 7)
    TrayTip("Backup v0.1", "Бекап запущен", 2, 1)
    Opt("TrayOnEventMode", 1)
    Opt("GUIOnEventMode", 1)
    Opt("SendCapslockMode", 0)
    Opt("TrayMenuMode", 1 + 2)
    $trayCreateBackup = TrayCreateItem("Создать бекап")
    TrayItemSetOnEvent($trayCreateBackup, "_CreateBackup")
    TrayCreateItem("")
    $aboutitem = TrayCreateItem("О программе")
    TrayCreateItem("")
    $exititem = TrayCreateItem("Exit")
    TrayItemSetOnEvent($aboutitem, "About")
    TrayItemSetOnEvent($exititem, "Exit1")

;Функция перевода времени в милисекунды
Func _TimeConv($time)
    $time = $time * 60000
    Return $time
    EndFunc

; ###Архивация и бекап!!! 
    Func _CreateBackup()
        $sDate = "" & @MDAY  & @MON  & @YEAR & "_" & @HOUR & @MIN 
        $sTemplate7z = $sDate & "_backup.7z"
        $sKey7z = "a -t7z "& $pBackupDir &"\"&$sTemplate7z & " -mx3 " & $pFileDir & " -ssw"
        If FileExists($pBackupDir & "\" & $sTemplate7z) Then
            TrayTip("Backup v0.2", "Резервная копия " & $sTemplate7z & " уже существует!", 5, 1)
            ;MsgBox (64,"Backup v0.1", "Резервная копия" & $sTemplate7z & "уже существует!")
            sleep (10000)
        Else
        ShellExecuteWait( @ScriptDir & "/7zip/7z.exe", $sKey7z)
             ; Вывод уведомления о создании бекапа
            _dbg("Backup complete!")
            TrayTip("Backup v0.2", "Создана новая резервная копия", 5, 1)
            sleep (10000)
        EndIf
    EndFunc

  ; Функции пунктов меню трея  
    Func About()
        Msgbox(64,"О программе","Backup v0.2 ")
    EndFunc  
    Func Exit1()
        Exit
    EndFunc   ;==>Exit1

; Цикл проверяет условия создания бекапа с определенной переодичностью
    While 1
        $fDate = "" & @MDAY  & @MON  & @YEAR & "_" & @HOUR & @MIN & "_*"
        ;$fDate = "" & @MDAY  & @MON  & @YEAR & "_*"
        If (@MDAY = $backupDay) And (FileExists($pBackupDir & "\" & $fDate) = 0) Then _CreateBackup()
        Sleep(_TimeConv($CheckBackupTime))
     WEnd
