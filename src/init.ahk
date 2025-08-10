#NoEnv
#Warn
#SingleInstance Force

SendMode, input
;~ SetCapsLockState, alwaysoff
SetNumLockState, alwayson
SetScrollLockState, AlwaysOff
SetTitleMatchMode, 1
CoordMode, Mouse, screen

SetWorkingDir, %A_ScriptDir%

#Include config/constants.ahk
#Include Lib/functions.ahk

global paths := new PathClass
global schedule := new ScheduleClass


if (debug!=0) {
	AsAdmin := 0
	change_env_mode(paths, "debug")
}


if ((A_ComputerName="HEPHAESTUS") or schedule.check_working())
	change_env_mode(paths, "work", 1)


get_screens_data(screens)
paths.load()
;~ generateMenus()
HS := LoadHotstrings(paths["hotstring_ini"])
render_hotstrings(HS)

;~ Run watchdog.ahk

; load groups
for group, g_list in control_groups {
	for _, program in g_list {
		if InStr(program, "exe")
			GroupAdd, %group%, ahk_exe %program%
		else
			GroupAdd, %group%, %program%
	}
}


If AsAdmin and not A_IsAdmin
	Run, *RunAs autohotkey.exe "%A_ScriptFullPath%" /restart

#If (work_mode!=0)
	#Include program_specific/vnc.ahk

#Include program_specific/chatgpt.ahk


#Include cli/Keyboard_bindings.ahk