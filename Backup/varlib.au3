; Подключение конфига объявление переменных
Global Const $config = @ScriptDir & '\conf.ini'
Global Const $mConfState = IniRead($config, "MAIN", "CONF_STATE", "e")
Global Const $backupDay = IniRead($config, "MAIN", "BACKUP_DAY", "")
Global Const $backupHour = IniRead($config, "MAIN", "BACKUP_HOUR", "")
Global Const $CheckBackupTime = IniRead($config, "MAIN", "CHECK_BACKUP_TIME", "")
Global Const $cleanDir = IniRead($config, "MAIN", "CLEAN_DIR", "")
Global Const $pFileDir = IniRead($config, "PATH", "FILE_DIR", "")
Global Const $pBackupDir = IniRead($config, "PATH", "BACKUP_DIR", "")
Global Const $z7Key = IniRead($config, "7Z", "7Z_KEY", "False")
Global Const $z7BDKey = IniRead($config, "7Z", "BACKUP_DIR_KEY", "")
Global Const $z7FDKey = IniRead($config, "7Z", "FILE_DIR_KEY", "")

Global $default7zKey = 0
Global $version = "alpha v0.4"
Global $progname = "Backup"
; Массив содержащий сообщения об ошибках
Global $errors[0]
