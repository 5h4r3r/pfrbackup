#include <Array.au3>
#include "errorcheck.au3"
;#include <Constants.au3>
;#include <Misc.au3>
;#include <GUIConstantsEx.au3>
TraySetIcon('shell32.dll', 7)
TrayTip("Backup v0.1", "Бекап запущен", 2, 1)
;ReadConfig()
;ErorrsDisplay()

Func AddSchTasks()
    Run(@ComSpec & " /c " & "SchTasks /Create /SC ONCE /TN BACKUP /TR \test.exe  /ST 17:00")
    ;Run(@ComSpec & " /c " & "SchTasks /Create /SC ONCE /TN MyTask /TR" & @ScriptDir & "\test.exe  /ST 16:50")
    EndFunc
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
    sleep (10000)
    EndFunc
    AddSchTasks()
    CreateBackup()
