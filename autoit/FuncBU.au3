#include <Array.au3>
#include <File.au3>
;
; Вывод текста в дебаг консоль
;
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
Func _TrayDelete1()
    $Info = MsgBox(4 + 32, "Очистка", "Вы уверены что хотите удалить все файлы в директории? " & $pFileDir)
    If $info = 6 Then _Delete($pFileDir)
    EndFunc
Func _TrayDelete2()
    $Info = MsgBox(4 + 32, "Очистка", "Вы уверены что хотите удалить все файлы в директории? " & $pBackupDir)
    If $info = 6 Then _Delete($pBackupDir)
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
;    
Func _ReadConfig()
    ; Проверка наличия конфига
    If FileExists($config) Then
        If $pFileDir And $pBackupDir And $backupDay And $CheckBackupTime And $backupHour And $cleanDir Then
            ; Если значение не TRUE Записываем
            If $mConfState <> "True" Then
                IniWrite ($config, "MAIN", "CONF_STATE", "True")
                ;_dbg("write true in config file!")
            EndIf
            ; Проверка параметра очистки директорий
                If ($cleanDir <> "True") And ($cleanDir <> "False") Then
                        _ArrayAdd ($errors,"Неверное значения параметра очистки директорий")
                EndIf
                    ; Проверка ключей 7z
                    If $z7Key And $z7BDKey And $z7FDKey Then
                        ;_dbg("7z key true") 
                        $default7zKey = 1  
                    Else
                        ;_dbg("7z default key set")
                        $default7zKey = 0
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
;
; Проверка директорий бекапа
;
Func _DirCheck()
If FileExists($pFileDir) And FileExists($pBackupDir) Then
    ;_dbg("### Directory " & $pFileDir & " exists")
    ;_dbg("### Directory " & $pBackupDir & " exists")
    Else
    ;_dbg("### Directory not exists!")
    _ArrayAdd ($errors,"Указанные директории отсутствуют")
    EndIf
EndFunc
;
; Вывод массива с ошибками на экран
;
Func _ErorrsDisplay()
    If UBound($errors) <> 0 Then
        _ArrayDisplay ($errors, "ErrorsDisplay")
        Exit
    Else
        _dbg("Test complete!")
        ;MsgBox (64,"ErrorsDisplay", "Ошибки отсутствуют", $errors)
EndIf
EndFunc
;
; Функция архивации и бекапа
; Добавить параметры 7z в конфиг     
;    
Func _CreateBackup()
    $sDate = "" & @MDAY  & @MON  & @YEAR & "_" & @HOUR & @MIN 
    $sTemplate7z = $sDate & "_backup.7z"
    ; Проверка установки ключей 7z
    if $default7zKey = 0 Then
        ;DEFAULT
        _dbg("DEFAULT") 
    $sKey7z = "a -t7z " & $pBackupDir & "\" & $sTemplate7z & " -mx3 " & $pFileDir & " -ssw"
    Else
        ;MANUAL
        _dbg("MANUAL") 
    $sKey7z = $z7Key & " " & $pBackupDir & "\" & $sTemplate7z & " " & $z7BDKey & " " & $pFileDir & " " & $z7FDKey
    EndIf
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
; Функция рекурсивной очистки каталогов
;
Func _Delete($source)
    TrayTip($progname, "Запущена очистка директорий", 5, 1)
    sleep (10000)
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
     _dbg("Backup dir cleaned!")
    EndFunc