#NoEnv
#Warn
;~ SetWorkingDir %A_ScriptDir%
#Include functions.ahk

#Include functions.ahk
If debug
	#Include analytic.ahk

If AsAdmin and not A_IsAdmin
	Run, *RunAs autohotkey.exe "%A_ScriptFullPath%" /restart

get_screens_data(screens, debug)

global paths := new PathClass
paths.load()

;~ generateMenus()

iniFile := paths["ahk"] . "\hotstrings.ini"
HS := LoadHotstrings(iniFile)
render_hotstrings(HS)

;~ Run watchdog.ahk

#If (A_ComputerName="HEPHAESTUS")
	#INCLUDE vnc.ahk
#If