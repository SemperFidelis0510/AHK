﻿#NoEnv
#Warn

store_hotstring() {
	local key, text0
	InputBox, key, Key Name, Please enter key name
	if !ErrorLevel {
		text0 := GetSelectedText()
		msgbox % text
		run_cmd(paths, "save_vnc_hotstring", [text0, "memory/vnc_htostrings.json", key], 2,,, 1)
	}
	return
}


#IfWinActive ahk_exe vncviewer.exe


!Tab::Send, ^+l

^WheelRight::+^k
^WheelLeft::+^l

^+h::store_hotstring()

::secbr:://--------------------------------------------------------

#IF
