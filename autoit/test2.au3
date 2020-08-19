;;;
;;; Рекурсивная функция удаления файлов c заданым расширением и старше N дней от текущей даты
;;;
; Вывод текста в дебаг консоль
#include <Array.au3>
#include <File.au3>
#include <Date.au3>
Func _dbg($sMsg)
    If @Compiled Then
        DllCall("kernel32.dll", "none", "OutputDebugString", "str", $sMsg)
    Else
        ConsoleWrite($sMsg & @CRLF)
    EndIf
EndFunc

 $source = "D:\Test"
Func _Delete($source)
 
    $aFolders = _FileListToArray($source, '*', 2) ; массив папок
     $aFiles = _FileListToArray($source, '*', 1) ; массив файлов
     ;_dbg($aFolders[0])
    If Not IsArray($aFolders) AND Not IsArray($aFiles) Then Return ''; Папки и файлы не найдены
     ;
     ; цикл по файлам текущей папки...
     ;
    _dbg("Dir ==>" & $source & '\' ) ; вывод текущей папки
     If IsArray($aFiles) Then
     For $j = 1 to $aFiles[0]
     ; если расширения файла совпадает и даты попадают в заданный диапазон дней
        _dbg("File del! =>" & $source & '\' & $aFiles[$j]) ; вывод файла
        ; УДАЛЕНИЕ ФАЙЛА!!!
        FileDelete($source & '\' & $aFiles[$j])
     Next
     EndIf
     ;
     ; рекурсия по подкаталогам...
     ;
     If IsArray($aFolders) Then
     For $i = 1 to $aFolders[0]
     $new_source = $source & '\' & $aFolders[$i] ; выбираем очередной подкаталог из массива
     _Delete($new_source) ; и выполняем рекурсивный вызов для подкаталогов
     Next
     EndIf
    EndFunc
    _Delete($source)