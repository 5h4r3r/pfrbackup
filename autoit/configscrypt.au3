Global Const $config = @ScriptDir & '\conf.ini'
Global Const $mConfState = IniRead($config, "MAIN", "CONF_STATE", "")
Global Const $pFileDir = IniRead($config, "PATH", "FILE_DIR", "")
Global Const $pBackupDir = IniRead($config, "PATH", "BACKUP_DIR", "")
Msgbox (64,"Дериктории бекапа", "Начальная директория " & $pFileDir & @CRLF & "Конечная директория " & $pBackupDir)