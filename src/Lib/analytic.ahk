#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#InstallKeybdHook
#InstallMouseHook

enum_screens() {
	local
	txt := ""

	SysGet, prim_scr, MonitorPrimary
	txt .= "Primary screen index: " . prim_scr . "`n"

	sysget, N, MonitorCount
	Loop, %N%	{
		sysget, scr, MonitorName, %A_Index%
		sysget, scr_dim, Monitor, %A_Index%
		txt .= "`nScreen index: " . A_Index
		txt .= "`nScreen name: " . scr
		txt .= "`nScreen coordinates: " . (prim_scr=scr)
		txt .= "`n`tXAxis = [" . scr_dimLeft . ", " . scr_dimRight . "] "
		txt .= "`n`tYAxis = [" . scr_dimTop . ", " . scr_dimBottom . "] "
		if (A_Index<N)
			txt .= "`n"
	}
	msgbox %txt%
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