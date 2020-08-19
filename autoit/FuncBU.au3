#include <Array.au3>
#include <File.au3>
; Вывод текста в дебаг консоль
Func _dbg($sMsg)
    If @Compiled Then
        DllCall("kernel32.dll", "none", "OutputDebugString", "str", $sMsg)
    Else
        ConsoleWrite($sMsg & @CRLF)
    EndIf
EndFunc
;
;Функция перевода времени в милисекунды
;
Func _TimeConv($time)
    $time = $time * 60000
    Return $time
    EndFunc
;
; Функции пунктов меню трея 
; 
    Func _TrayDelete()
        _Delete($pFileDir)
        EndFunc
    Func About()
        Msgbox(64,"О программе",$progname & $version)
    EndFunc  
    Func Exit1()
        Exit
    EndFunc   ;==>Exit1
; 
; Прооверяет существует ли конфиг
; В случае неудаи Сообщение об ошибке пишется в массив
Func _ReadConfig()
    If FileExists($config) Then
        If $pFileDir And $pBackupDir And $backupDay And $CheckBackupTime And $backupHour And $cleanDir Then
            ;_dbg ("test check!")
            ; Если значение не TRUE Записываем
            If $mConfState <> "True" Then
                IniWrite ($config, "MAIN", "CONF_STATE", "True")
                _dbg ("write true in config file!")
            EndIf
            If ($cleanDir <> "True") And ($cleanDir <> "False") Then
                _ArrayAdd ($errors,"Неверное значения параметра очистки директорий")
            EndIf
            Return True
            Else    
            _ArrayAdd ($errors,"Отсутствуют обязательные параметры в файле конфигурации")
            Return False
        EndIf
        Else
            _ArrayAdd ($errors,"Отсутствует файл конфигурации")
            Return False
            EndIf     
EndFunc
; Проверка директорий бекапа
Func _DirCheck()
If FileExists($pFileDir) And FileExists($pBackupDir) Then
    ;_dbg("### Directory " & $pFileDir & " exists")
    ;_dbg("### Directory " & $pBackupDir & " exists")
    Else
    ;_dbg("### Directory not exists!")
    _ArrayAdd ($errors,"Указанные директории отсутствуют")
    EndIf
EndFunc
; Вывод массива с ошибками на экран
Func _ErorrsDisplay()
    If UBound($errors) <> 0 Then
        _ArrayDisplay ($errors, "ErrorsDisplay")
    Else
        _dbg("Test complete!")
        ;MsgBox (64,"ErrorsDisplay", "Ошибки отсутствуют", $errors)
EndIf
EndFunc
;
; Функция рекурсивной очистки каталогов
;
Func _Delete($source)
    $aFolders = _FileListToArray($source, '*', 2) ; массив папок
     $aFiles = _FileListToArray($source, '*', 1) ; массив файлов
    If Not IsArray($aFolders) AND Not IsArray($aFiles) Then Return ''; Папки и файлы не найдены
     ;
     ; цикл по файлам текущей папки...
     ;
     If IsArray($aFiles) Then
     For $j = 1 to $aFiles[0]
        _dbg("File del!" & $source & '\' & $aFiles[$j])
        ; ФУНКЦИЯ УДАЛЕНИЯ!
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