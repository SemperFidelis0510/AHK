#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#InstallKeybdHook
#InstallMouseHook

enum_screens() {
	local
	sysget, n, MonitorCount
	Loop, n {
		sysget, scr, MonitorName, %A_Index%
		msgbox the name of screen number %A_Index% is %scr%
	}
	SysGet, scr, MonitorPrimary
	msgbox the primary screen is %scr%
	return
}

name_computer() {
	msgbox, %A_ComputerName%
	return
}

get_activeWin_hwnd() {
	local
	actWin := WinActive("A")
	ControlGet, var1, Hwnd,,, ahk_id %actWin%
	msgbox, %var1%
	return
}

get_mouse_pos() {
	local
	CoordMode, Mouse, Screen
	MouseGetPos, X, Y
	msgbox % X . ":" . Y
	return
}

get_pressed_key(all:=0) {
	local
	If all
		KeyHistory
	Else {
		Input, x,, {Enter}
		MsgBox % A_Priorkey
	}
	return
}