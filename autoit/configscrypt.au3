#include <Array.au3>
Global Const $config = @ScriptDir & '\conf.ini'
Global Const $mConfState = IniRead($config, "MAIN", "CONF_STATE", "")
Global Const $pFileDir = IniRead($config, "PATH", "FILE_DIR", "")
Global Const $pBackupDir = IniRead($config, "PATH", "BACKUP_DIR", "")
Global $errors[0]
; Прооверяет существует ли конфиг
; В случае неудаи Сообщение об ошибке пишется в массив
Func ReadConfig()
    If FileExists($config) Then
        If $mConfState And $pFileDir And $pBackupDir Then
            MsgBox (448,"Тест пройден",$pFileDir)
            Else    
            _ArrayAdd ($errors,"Отсутствуют обязательные параметры в файле конфигурации")
        EndIf
        Else
            _ArrayAdd ($errors,"Отсутствует файл конфигурации")
            Return True
            EndIf
EndFunc
;Отчет об ошибках
Func ErorrsDisplay()
    If UBound($errors) <> 0 Then
        _ArrayDisplay ($errors, "ErrorsDisplay")
        MsgBox (64,"ErrorsDisplay", "", $errors)
    Else
        ;MsgBox (64,"ErrorsDisplay", "Ошибки отсутствуют", $errors)
        Return True
EndIf
EndFunc
ReadConfig()
ErorrsDisplay()