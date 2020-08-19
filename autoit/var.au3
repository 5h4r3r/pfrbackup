; Подключение конфига объявление переменных
Global Const $config = @ScriptDir & '\conf.ini'
Global Const $mConfState = IniRead($config, "MAIN", "CONF_STATE", "")
Global Const $backupDay = IniRead($config, "MAIN", "BACKUP_DAY", "")
Global Const $backupHour = IniRead($config, "MAIN", "BACKUP_HOUS", "")
Global Const $CheckBackupTime = IniRead($config, "MAIN", "CHECK_BACKUP_TIME", "")
Global Const $cleanDir = IniRead($config, "MAIN", "CLEAN_DIR", "")
Global Const $pFileDir = IniRead($config, "PATH", "FILE_DIR", "")
Global Const $pBackupDir = IniRead($config, "PATH", "BACKUP_DIR", "")
Global $version = " v0.2"
Global $progname = "Backup"
; Массив содержащий сообщения об ошибках
Global $errors[0]