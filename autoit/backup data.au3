#include <Array.au3>
#include <File.au3>
#include <Date.au3>
; Вывод текста в дебаг консоль
Func _dbg($sMsg)
    If @Compiled Then
        DllCall("kernel32.dll", "none", "OutputDebugString", "str", $sMsg)
    Else
        ConsoleWrite($sMsg & @CRLF)
    EndIf
EndFunc

$sDir = "D:\Git\pfrbackup\autoit\F1"
$aFileList = _FileListToArray($sDir)

Func InputDataFile()
    For $i = 1 to UBound($aFileList) - 1
        $aFileTime = FileGetTime($sDir & "\" & $aFileList[$i], 0, 0)
        $aDataForm = $aFileTime[0] & "/" & $aFileTime[1] & "/" &  $aFileTime[2] & " " & $aFileTime[3] & ":" & $aFileTime[4] & ":" &  $aFileTime[5]
;_ArrayDisplay($aFileList)
;MsgBox(0, '','Время создания файла: ' & $aFileList[$i] & "-" & _DateTimeFormat($aDataForm,2))
        ;_dbg(_DateAdd('d',+1,$aDataForm) & " " & _NowCalcDate())
            ;If $aDataForm = _DateAdd('d',-1,_NowCalcDate()) Then
            ;If _DateDiff( 'd',$aDataForm, _NowCalc())
        $dDiff = _DateDiff( 'd', $aDataForm, _NowCalc())
        _dbg( $dDiff & " " & $aDataForm & " " & _NowCalc())
        MsgBox( 4096, "", "Number of Hours this year: " & $dDiff)
;_dbg('Time to create file: ' & $aFileList[$i] & " " & $aDataForm & " " & _NowCalc())
 ;EndIf
Next 
EndFunc
InputDataFile()
