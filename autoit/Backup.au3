#include "var.au3"
#include "FuncBU.au3"
; Вызов проверок
_ReadConfig()
_DirCheck()
_ErorrsDisplay()
_dbg($cleanDir)
;
; Настройка трея
;
    TraySetIcon('shell32.dll', 7)
    TrayTip($progname, "Бекап запущен", 2, 1)
    Opt("TrayOnEventMode", 1)
    Opt("GUIOnEventMode", 1)
    Opt("SendCapslockMode", 0)
    Opt("TrayMenuMode", 1 + 2)
    $trayCreateBackup = TrayCreateItem("Создать бекап")
    TrayItemSetOnEvent($trayCreateBackup, "_CreateBackup")
    TrayCreateItem("")
    $trayCleanDir = TrayCreateItem("Удалить файлы в директории!")
    TrayItemSetOnEvent($trayCleanDir, "_TrayDelete")
    TrayCreateItem("")
    $aboutitem = TrayCreateItem("О программе")
    TrayCreateItem("")
    $exititem = TrayCreateItem("Exit")
    TrayItemSetOnEvent($aboutitem, "About")
    TrayItemSetOnEvent($exititem, "Exit1")

;
; ###Архивация и бекап!!! 
;    
    Func _CreateBackup()
        $sDate = "" & @MDAY  & @MON  & @YEAR & "_" & @HOUR & @MIN 
        $sTemplate7z = $sDate & "_backup.7z"
        $sKey7z = "a -t7z "& $pBackupDir &"\"&$sTemplate7z & " -mx3 " & $pFileDir & " -ssw"
        If FileExists($pBackupDir & "\" & $sTemplate7z) Then
            TrayTip($progname, "Резервная копия " & $sTemplate7z & " уже существует!", 5, 1)
            ;MsgBox (64,"Backup v0.1", "Резервная копия" & $sTemplate7z & "уже существует!")
            sleep (10000)
        Else
        ShellExecuteWait( @ScriptDir & "/7zip/7z.exe", $sKey7z)
             ; Вывод уведомления о создании бекапа
            _dbg("Backup complete!")
            TrayTip($progname, "Создана новая резервная копия", 5, 1)
            sleep (10000)
        EndIf
    EndFunc
; 
; Цикл проверяет условия создания бекапа с определенной переодичностью
;
    While 1
        ; Время ожидания до запуска следующей проверки 
        Sleep(_TimeConv($CheckBackupTime))
        $fDate = "" & @MDAY  & @MON  & @YEAR & "_" & @HOUR & @MIN & "_*"
        ;$fDate = "" & @MDAY  & @MON  & @YEAR & "_*"
        ; Проверка условий запуска бекапа
        If (@MDAY = $backupDay) And (@HOUR = $backupHour) And (FileExists($pBackupDir & "\" & $fDate) = 0) Then
            _CreateBackup()
            ; Очистка директорий
            If $cleanDir = "True" Then
                TrayTip($progname, "Запущена очистка директорий", 5, 1)
                sleep (10000)
                _Delete($pFileDir)
                _dbg("Backup dir cleaned!")
            EndIf
        EndIf
     WEnd
