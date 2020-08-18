#include <Array.au3>
; Подключение конфига объявление переменных
Global Const $config = @ScriptDir & '\conf.ini'
Global Const $mConfState = IniRead($config, "MAIN", "CONF_STATE", "")
Global Const $backupDay = IniRead($config, "MAIN", "BACKUP_DAY", "")
Global Const $CheckBackupTime = IniRead($config, "MAIN", "CHECK_BACKUP_TIME", "")
Global Const $pFileDir = IniRead($config, "PATH", "FILE_DIR", "")
Global Const $pBackupDir = IniRead($config, "PATH", "BACKUP_DIR", "")
; Массив содержащий сообщения об ошибках
Global $errors[0]

; Вывод текста в дебаг консоль
Func _dbg($sMsg)
    If @Compiled Then
        DllCall("kernel32.dll", "none", "OutputDebugString", "str", $sMsg)
    Else
        ConsoleWrite($sMsg & @CRLF)
    EndIf
EndFunc

; Прооверяет существует ли конфиг
; В случае неудаи Сообщение об ошибке пишется в массив
Func _ReadConfig()
    If FileExists($config) Then
        If $pFileDir And $pBackupDir And $backupDay And $CheckBackupTime Then
            ;_dbg ("test check!")
            ; Если значение не TRUE Записываем
            If $mConfState <> "True" Then
                IniWrite ($config, "MAIN", "CONF_STATE", "True")
                _dbg ("write true in config file!")
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
_ReadConfig()
_DirCheck()
_ErorrsDisplay()