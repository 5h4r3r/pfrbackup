#include <File.au3>
;$confFile = FileOpen(@ScriptDir & '\path.conf', 0)
;If $confFile = -1 Then
  ;  MsgBox(4096, "Ошибка", "Невозможно открыть файл.")
 ;   Exit
;EndIf
Local $aRecords
Local $massage
If Not _FileReadToArray(@ScriptDir & "\path.conf", $aRecords) Then
    MsgBox(4096, "Ошибка", " Ошибка чтения файла в массив     Ошибка = " & @error)
    Exit
EndIf
For $i = 1 To $aRecords[0]
    $massage &= @CRLF & $aRecords[$i]
Next
MsgBox(4096, 'Строка:', $massage)