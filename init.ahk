#NoEnv
#Warn
;~ SetWorkingDir %A_ScriptDir%
#Include functions.ahk

#Include functions.ahk
If debug
	#Include analytic.ahk

If AsAdmin and not A_IsAdmin
	Run, *RunAs autohotkey.exe "%A_ScriptFullPath%" /restart

global paths := new PathClass
paths := LoadPaths(paths)
generateMenus()
LoadHotstrings()
render_hotstrings(HS)

;~ Run watchdog.ahk

#If (A_ComputerName="HEPHAESTUS")
	#INCLUDE vnc.ahk
#If