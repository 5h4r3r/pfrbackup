#include <Array.au3>
#include "errorcheck.au3"
;#include <Constants.au3>
;#include <Misc.au3>
;#include <GUIConstantsEx.au3>
Local $Clock = GUICtrlCreateLabel(@HOUR & ":" & @MIN & ":" & @SEC & ":" & @MSEC, 50, 20)
TrayTip("Backup v0.1", "Бекап запущен", 2, 1)

;ReadConfig()
;ErorrsDisplay()

; Проверка директорий бекапа
If FileExists($pFileDir) And FileExists($pBackupDir) Then
    _dbg("### Directory " & $pFileDir & " exists")
    _dbg("### Directory " & $pBackupDir & " exists")
    Else
    _dbg("### Directory not exists!")
    EndIf
   ; ###Архивация и бекап!!! 
    Func CreateBackup()
    $sDate = "" & @MDAY  & @MON  & @YEAR & "_" & @HOUR & @MIN 
    $sTemplate7z = $sDate & "_backup.7z"
	$sKey7z = "a -t7z "& $pBackupDir &"\"&$sTemplate7z & " -mx3 " & $pFileDir & " -ssw"
    ShellExecuteWait( @ScriptDir & "/7zip/7z.exe", $sKey7z)
    ; Вывод уведомления о создании бекапа
    TrayTip("Backup v0.1", "Создана новая резервная копия", 5, 1)
    EndFunc
    
; Отрисовка трея
TraySetIcon('shell32.dll', 7)
Opt("TrayOnEventMode", 1)
Opt("GUIOnEventMode", 1)
Opt("SendCapslockMode", 0)
Opt("TrayMenuMode", 1 + 2)
$trayCreateBackup = TrayCreateItem("Создать бекап")
TrayItemSetOnEvent($trayCreateBackup, "CreateBackup")
TrayCreateItem("")
$aboutitem = TrayCreateItem("О программе")
TrayCreateItem("")
$exititem = TrayCreateItem("Exit")

TrayItemSetOnEvent($aboutitem, "About")
TrayItemSetOnEvent($exititem, "Exit1")

While 1
    $timer = TimerInit()
    Do
        If TimerDiff($timer) > 60000 Then
            _dbg("vivod")
            ;MsgBox (0,"Timer Alert","The timer has hit 20 minutes!")
            CreateBackup()
        EndIf
    Until TimerDiff ($timer) > 60000
    WEnd

Func About()
    Msgbox(64,"О программе","Backup v0.1")

EndFunc  
Func Exit1()
    Exit
EndFunc   ;==>Exit1