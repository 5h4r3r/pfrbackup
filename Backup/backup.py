import configparser
import os

def readConf(path):
    global confstate
    config = configparser.ConfigParser()
    config.read(path)
    
    confstate = config.get("MAIN", "CONF_STATE")

path = "Backup.py/conf.ini"
readConf(path)
print(confstate) 
os.system("pause")