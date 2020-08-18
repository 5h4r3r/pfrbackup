$t = FileGetTime("D:\Git\pfrbackup\autoit\F1\File03.txt", 1)

If Not @error Then
    $yyyymd = $t[0] & "/" & $t[1] & "/" & $t[2]
    MsgBox(0, "Возвращает дату создания файла notepad.exe", $yyyymd)
EndIf